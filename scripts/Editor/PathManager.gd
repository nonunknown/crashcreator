extends Spatial


var pathList = []
export var path:PackedScene

func SpawnPath(from_file=false,position=null,modelName=null):
	var instance = null
	
	if from_file:
		instance = import_model(modelName).instance()
		instance.translation = position		
	else:
		instance = path.instance()
		instance.translation = Vector3(0,0,0+(pathList.size() * 10))
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
