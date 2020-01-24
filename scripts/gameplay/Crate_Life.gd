extends Crate

export var item_life:PackedScene

func spawn_life():
	var inst = item_life.instance()
	get_parent().add_child(inst)
	inst.translation = translation

func _on_Attacked():
	spawn_life()
	Destroy()

func _on_Jumped():
	_on_Attacked()
	

func _on_Exploded():
	_on_Attacked()


func _on_Area_area_entered(area):
	
	pass # Replace with function body.
