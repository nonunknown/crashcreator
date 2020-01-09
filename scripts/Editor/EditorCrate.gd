extends Spatial
class_name EditorCrate

var _ID = -1

func get_data() -> Dictionary: return {id=_ID,pos=translation}
