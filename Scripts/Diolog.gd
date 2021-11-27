extends Node2D

enum {on_dialog,out_dialog}
var status = out_dialog
var wait_time = 2

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
	"Plot3",
	"Plot3",
	"Plot3",
	"Plot3"
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
		

func _on_Tween_tween_completed(object, key):
	finished = true

func _on_dialogue_timer_timeout():
	status = out_dialog


func _on_Next_pressed():
	button = pressed
