extends Spatial
class_name EditorCrate

var _ID:int = -1
var _time_ID:int = 0
var editor_material:SpatialMaterial

func configure(id):
	_ID = id
	editor_material = get_child(0).get_material_override()

func get_data() -> Dictionary: return {id=_ID,time_id=_time_ID,pos=translation}
