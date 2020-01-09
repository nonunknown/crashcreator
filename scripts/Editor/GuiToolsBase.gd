extends Control
class_name GuiToolsBase

var _ID:int = -1
onready var tools_manager:GUI_tools_Manager = GUI_tools_Manager.new(_ID,self)

func _ready():
	if (_ID == -1): printerr("At GUITOOLSBASE ID IS -1")
	tools_manager._ready()

func _on_tool_started():
	visible = true
	pass
	
func _on_tool_exited():
	visible = false
	pass
