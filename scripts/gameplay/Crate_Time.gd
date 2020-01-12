extends Crate
class_name CrateTime

func set_crate_time(n):
	if not (n>= 0 and n<= 3): return
	$model.set_surface_material(0,IDTable.material_crate_time[n])

func _on_Attacked():
	Destroy()

func _on_Jumped():
	_on_Attacked()
	
func _on_Exploded():
	_on_Attacked()
