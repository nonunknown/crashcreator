extends Control

# ID - 0

onready var model_list:Array = list_files_in_directory("res://gameplay/level/tv")
onready var path_manager = get_node("../../Level/Path")
onready var editor_manager = get_node("/root/Main")
#placeable Model Paths
var bt_model_path:String = "TabContainer/Built-in/GridContainer/"
export var bt_base_model:PackedScene

func _ready():
	editor_manager.connect("change_mode",self,"_on_mode_changed")
	pass
#	editor_manager.connect("on_")

func _on_mode_changed(_tool):
	if (!_tool == 0): return
	load_models()
	pass

func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files


func load_models():
	match visible:
		true:
			print( path_manager.get_all_paths() )
			list_models()
		false:
			pass
	pass # Replace with function body.

var listed:bool = false
func list_models():
	if listed: return
	if !listed: listed = true
	for model_name in model_list:
		var bt = bt_base_model.instance()
		get_node(bt_model_path).add_child(bt)
		bt.start(model_name)
		
func toggle_bt_add(toggle):
	$Panel/VBoxContainer/bt_add.disabled = toggle;
	

