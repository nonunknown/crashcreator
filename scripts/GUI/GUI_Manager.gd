extends Control

export var bts_menu:ButtonGroup

onready var gui_path_properties:Control = $GUI_path_properties
onready var gui_path_tools:Control = $GUI_tools_path

var tool_windows = []

func _ready():
	tool_windows = [gui_path_tools]
	pass

func clear(except=null):
	for window in tool_windows:
		if (window == except):
			continue
		window.visible = false

func _on_bt_edit_path_toggled(button_pressed):
	if (button_pressed):
		clear(gui_path_tools)
		gui_path_tools.visible = true



func _on_bt_edit_crate_toggled(button_pressed):
	clear()
	pass # Replace with function body.
