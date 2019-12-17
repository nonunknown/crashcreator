extends Control

onready var model_list:Array = list_files_in_directory("res://gameplay/level/tv")

#placeable Model Paths
var bt_model_path:String = "TabContainer/Built-in/GridContainer/"
export var bt_base_model:PackedScene

func _ready():
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

onready var path_manager = get_node("../../Level/Path")

func _on_GUI_tools_path_visibility_changed():
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
