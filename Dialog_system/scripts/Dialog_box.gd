extends Control

enum {on_dialog,out_dialog}
var status = out_dialog
var wait_time = 2

onready var dialog = [
	"mal posso esperar para chegar em casa e comer meu sorvete",
	"tem um pote com meu sabor favorito",
	"chocolate!",
	"^.^",
	"finalmente cheguei em casa!",
	"vou pegar meu sorvete!",
	"O.O''",
	"que brincadeira é essa?",
	"não tem mais sorvete!",
	"você pegou?",
	"como assim eu esqueci a geladeira aberta????",
	"você disse que jogou fora???",
	"não tem mais sorvete..."
]

var dialog_index = 0
var finished = false
var counter = 0 

	
func _process(delta):
	get_tree().paused = true
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("atack") and status == out_dialog:
		dialog_events()
		load_dialog()


func load_dialog():
	if dialog_index < dialog.size():
		status = on_dialog
		$"../dialogue_timer".start()
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		$RichTextLabel.push_align(RichTextLabel.ALIGN_CENTER)
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, wait_time,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($RichTextLabel,"draw")
		
	dialog_index += 1
	counter += 1 

	
func dialog_events():
	if dialog_index == dialog.size():
		hide()
		pass
		

func _on_Tween_tween_completed(object, key):
	finished = true

func _on_dialogue_timer_timeout():
	status = out_dialog
