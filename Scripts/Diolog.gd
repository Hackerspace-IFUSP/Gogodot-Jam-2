extends Node2D

enum {on_dialog,out_dialog}
var status = out_dialog
var wait_time = 2
var awake = 0
enum{paused,runing}
var pause = paused

enum{pressed,not_pressed}
var button = not_pressed

var dialog

onready var text0 = [
	"Neil: Captain! Captain! Something terrible came about!",
	"''What happun?",
	"Neil: The police stumbled upon us. They speak about illegal blocks used in the construction of the power plants!", 
	"Neil: Some tall blokes took all the plants to the prison themselves. Except for the wind powered, this one is legit.",
	"''I knew the cops would find out… But I swear, those blocks are completely safe!",
	"''It is so unfair that they are forbidden to use in power plants. What do we do?",
	"Neil: We can mine UCOIN and pay the fine to free the power plants.",
	"Neil: However, there is a catch. The fans are acting up and the power is not increasing according.",
	"''In layman terms, please!",
	"Neil: Of course, captain. We need someone to keep the fans on the rhythm of the beat to max the energy gain.",
	"Neil: Only you can do that, captain.",
	"Leave it to me! We are making some UCOIN!"
]

onready var text1 = [
	"Sabrina: ...and that’s why solar is my favourite! It has everything!",
	"Miyamoto: What’s the fun if there is no fan? I think it is pretty silly. They stay there without moving. Boring. You know what have fans? GPUs! GPUs are awesome! You can use them to game, but only kids do that. Real man use them to mine some sweet UCOIN!",
	"Mrs. Reneé: And where does the energy to power the GPUs come frooom?",
	"Miyamoto: Well… nevermind!"
]

onready var text2 = [
	"Mrs. Reneé: So, we need to phase out fossil fuel power plants ASAP!",
	"Sabrina: Yay!",
	"Miyamoto: But, but, I don’t get it! Can’t we just have enough money to buy like, a lot of carbon cleaning stuff? I bet that with many oil plants feeding enough GPUs we could get lots and lots of UCOIN! And then and them…",
]

onready var text3 = [
	"Neil: Good job, ol’ captain sir! We have released our most important power plant. Now the city will have all the energy needs fulfilled and mine extra UCOIN to boot. Well done! Also, did you knoooow that nuclear power plants are a ",
	"Mrs. Reneé: ...carbooon free solution as well? Just like wind, solar and hydro, but with more efficiency. The drawback is that it can have some seriooous accidents when people are careless.",
	"Sabrina: Like UCOINS…? They, like, are very dangerous if someone tweets something weird.",
	"Miyamoto: !!!",
	"Mrs. Reneé: No, not like that at aaall. While nuclear can go wrong when neglected, it is very difficult for accidents to truly happen. UCOIN, on the other hand, was bound to blooow up. And so it did.",
	"Miyamoto: W-What do you mean???",
	"Mrs. Reneé: Earlier this morning, the UCOIN market booombed. It lost 99.95% of it’s value overnight. I just saaaw it on the internet while you solved the last questions, actually.",
	"Miyamoto: NOOOOOOOOOOOOOOOOOOO!!!!!",
	"Neil! Man our stations! We are being attack-",
	"...",
	"What’s going on??",
	"Mrs. Reneé: Finally! Our sleeping beeeauty awakes! You missed the last task, so I have EXTRA homework for you.",
	"No… I will never have time to play like this!",
	"Miyamoto: It’s all those crooks at the government's fault! If they had banned all other currencies, then UCOIN would-",
	"Hey, listen, Miyamoto. I’m whispering so Mrs. Reneé can’t hear while Sabrina monologues about radioactive waste. What if I gave you all my stash of OMEGACOIN in exchange for you doing my homework? I farmed a lot in Farmcraft. It will lose value now, but I’m sure it"
]


var dialog_index = 0
var finished = false
var counter = 0 

func _ready():
	dialog = text0
	load_dialog()

	
func _process(delta):
	if pause == paused:
		get_tree().paused = true
	if button == pressed:
		dialog_events()
		load_dialog()


func load_dialog():
	if dialog_index < dialog.size():
		status = on_dialog
		$Control/dialogue_timer.start()
		finished = false
		$Control/Dialog_box/RichTextLabel.bbcode_text = dialog[dialog_index]
		$Control/Dialog_box/RichTextLabel.percent_visible = 0
		$Control/Dialog_box/RichTextLabel.push_align(RichTextLabel.ALIGN_CENTER)
		$Control/Dialog_box/Tween.interpolate_property(
			$Control/Dialog_box/RichTextLabel, "percent_visible", 0, 1, wait_time,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Control/Dialog_box/Tween.start()
		yield($Control/Dialog_box/RichTextLabel,"draw")
		
	dialog_index += 1 
	button = not_pressed

	
func dialog_events():
	if dialog_index == 10 and awake != 0:
		$Control/Dialog_box/TextBox.show()
	
	if dialog_index == dialog.size():
		dialog_index = -1
#		counter += 1
#		if counter == 1:
#			dialog = text1
#		elif counter == 2:
#			dialog = text2
#		elif counter == 3:
#			dialog = text3
			
		pause = runing
		hide()
		get_tree().paused = false 
		button = not_pressed
		$"../Bkg".play()
		
		if awake != 0:
			$"../Thanks/transition".play("event")
		

func _on_Tween_tween_completed(object, key):
	finished = true

func _on_dialogue_timer_timeout():
	status = out_dialog


func _on_Next_pressed():
	button = pressed
