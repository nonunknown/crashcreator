extends Control

export var bts_menu:ButtonGroup

onready var manager_editor:EditorManager = get_node("/root/Main")

func _ready():
	manager_editor.connect("tool_changed",self,"_on_tool_changed")
	
func _on_tool_changed(_tool):
	for gui in get_tree().get_nodes_in_group("gui_tool"):
		if (gui.tool_id == _tool):
			gui.visible = true
			continue
			
		else:
			gui.visible = false
#	if (gui_list.size()-1 >= _tool): #check if index exists on gui_list
#		clear(gui_list[_tool])
	pass


#func clear(except=null):
#	for gui in gui_list:
#		if (gui == except):
#			gui.visible = true
#			continue
#		gui.visible = false
#
