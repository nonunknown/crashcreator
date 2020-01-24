extends Crate
class_name CrateAku

export var item_aku:PackedScene

func spawn_aku():
	print("spawn")
	var inst = item_aku.instance()
	inst.translation = translation + ( Vector3.UP * .5)
	get_parent().add_child(inst)
	
func _on_Attacked():
	spawn_aku()
	Destroy()

func _on_Jumped():
	_on_Attacked()
	

func _on_Exploded():
	_on_Attacked()
