extends Spatial

var pathList = []
export var path:PackedScene

func SpawnPath():
	var instance = path.instance()
	add_child(instance)
	instance.translation = Vector3(0,0,0+(pathList.size() * 10))
	pathList.append(instance)
	

func data_register(): 
	pass

func _on_btAddPath_pressed():
	SpawnPath()

func _on_btSave_pressed():
	FileManager.save_path()
