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
	"Plot0",
	"Plot0",
	"Plot0",
	"Plot0"
]

onready var text1 = [
	"Plot1",
	"Plot1",
	"Plot1",
	"Plot1"
]

onready var text2 = [
	"Plot2",
	"Plot2",
	"Plot2",
	"Plot2"
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
