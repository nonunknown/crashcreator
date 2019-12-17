extends Node

var selected_single = null
var selected_multi = []

onready var path_manager = get_node("/root/Main/Level/Path")
onready var gui = get_node("/root/Main/GUI")
func selection_set_single(path):
	print("clicked")
	if (selected_single != null):
		selection_clear_single()
	if (path == null): 

		gui.gui_path_properties.visible = false
		selected_single = null

	else:
		
		selected_single = path
		selected_single.st_manager.change_state(selected_single.st_manager.states[selected_single.ST_SELECTED])
		gui.gui_path_properties.visible = true
	

func selection_get_single():
	return selected_single

func selection_clear_single():
	selected_single.st_manager.change_state(selected_single.st_manager.states[selected_single.ST_UNSELECTED])
