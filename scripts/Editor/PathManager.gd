extends Spatial

# -- About Selection

# -- END selection
var pathList = []
export var pa0:PackedScene
export var pa1: PackedScene
onready var paths = [pa0,pa1]
func get_random_path():
	paths.shuffle()
	return paths.front().instance()

func SpawnPath(from_file=false,position=null,modelName=null):
	var instance = null
	
	if from_file:
		instance = import_model(modelName).instance()
		instance.translation = position		
	else:
		instance = get_random_path()
		instance.translation = Vector3(0,0,0+(pathList.size() * 10))
	instance._on_ready()
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

func import_model(modelName):
	var prefix:String = FileManager.reg(modelName,".+?(?=_)")
	var p = "res://gameplay/level/"+prefix+"/model_"+modelName+".tscn"
	#print(p)
	return load(p)

func _on_btAddPath_pressed():
	SpawnPath()

func _on_btSave_pressed():
	FileManager.save_path()

func _on_btLoad_pressed():
	FileManager.load_level()
