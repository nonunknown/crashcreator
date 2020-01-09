extends Node

var selected_single = null
var selected_multi = []

onready var path_manager = get_node("/root/Main/Level/Path")
onready var crate_manager = get_node("/root/Main/Level/Crate")

onready var gui = get_node("/root/Main/GUI")

func _ready():
	Utils.connect("mouse_left_clicked",self,"_on_mouse_left_clicked")

func selection_set_single(selection):
	if (selected_single != null):
		selection_clear_single()
	if (selection == null): 

		gui.gui_path_properties.visible = false
		selected_single = null

	else:
		
		selected_single = selection
		selected_single.to_selected()
		gui.gui_path_properties.visible = true
	

func selection_get_single():
	return selected_single

func selection_clear_single():
	selected_single.to_unselected()
	

