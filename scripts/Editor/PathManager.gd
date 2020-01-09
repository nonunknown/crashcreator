extends Spatial
class_name PathManager
# -- About Selection

# -- END selection
var selected_model:String = ""
var pathList = []
var ID = 0
var editor_state:EditorState
var path_to_spawn = null

func _ready():
	editor_state = EditorState.new(Utils.EDITOR_STATE.PATH,self)
	get_tree().get_nodes_in_group("project_new")[0].connect("project_new",self,"_on_project_new")
	
func _enter():
	print("started path")
	list_level_models()
	pass

func _update():
	pass

func _exit():
	print("path exit")
	pass

signal generate_path_buttons
var loaded:bool = false
var path_loaded:Array = []
var path_list:Array = []

func list_level_models():
	if loaded: return
	path_list = Utils.list_directory("res://gameplay/level/tv/")
	for path in path_list:
		path_loaded.append(load(path))
	emit_signal("generate_path_buttons",path_loaded)
	loaded = true

func SpawnPath():
	var instance = path_to_spawn.instance()
#	instance = import_model(modelName).instance()
	if (pathList.size() == 0):
		instance.translation = Vector3.ZERO
	else:
		var pos = pathList[pathList.size()-1].get_node("PosEnd")
		instance.translation += pos.get_global_transform().origin

	instance._on_ready()
	add_child(instance)
	instance.set_owner(self)
	pathList.append(instance)



func _on_bt_add_pressed():
	SpawnPath()

func _on_project_new():
	pathList = []

func _on_set_path_to_spawn(name):
	for path in path_loaded:
		if (path.instance().show_name == name):
			path_to_spawn = path
			break
