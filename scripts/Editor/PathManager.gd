extends Spatial
# -- About Selection

# -- END selection
var pathList = []
export var pa0:PackedScene
export var pa1: PackedScene
onready var paths = [pa0,pa1]
var selected_model:String = ""
func get_random_path():
	paths.shuffle()
	return paths.front().instance()

func SpawnPath(from_file=false,position=null,modelName=null):
	var instance = null
	print(modelName)
	instance = import_model(modelName).instance()
	
	if from_file:
		instance.translation = position		
	else:
		if (pathList.size() == 0):
			instance.translation = Vector3.ZERO
		else:
			print("pathlist:")
			print(pathList)
			print("last from pathList")
			print(pathList.size()-1)
			print("pos:")
			var pos = pathList[pathList.size()-1].get_node("PosEnd")
			print(pos.get_global_transform())
			instance.translation = pos.get_global_transform().origin
	instance._on_ready()
	print("instance execute onready")
	add_child(instance)
	pathList.append(instance)
	
func generate_area(data):
		pathList = []
		print("loading:")
		print(data)
		for i in data:
			var info = data[i]
			var pos:Vector3 = Vector3(info.posX,info.posY,info.posZ)
			SpawnPath(true,pos,info.mName)
		
		pass


func get_model_show_name(modelName):
	return import_model(modelName).instance().show_name
func get_model_dir(modelName,extension_included=true):
	var prefix:String = FileManager.reg(modelName,".+?(?=_)")
	if not extension_included:
		modelName = modelName+".tscn"
	return "res://gameplay/level/tv/"+modelName

func import_model(modelName):
	var p = get_model_dir(modelName)
	print(p)
	return load(p)

func get_all_paths():
	return ["path0","path1"]

func set_selected_model(model_name):
	selected_model = model_name


func _on_btAddPath_pressed():
	SpawnPath()

func _on_btSave_pressed():
	FileManager.save_path()

func _on_btLoad_pressed():
	FileManager.load_level()


func _on_bt_add_pressed():
	SpawnPath(false,null,selected_model)
	pass # Replace with function body.
