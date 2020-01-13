extends Crate
class_name CrateTime

var gameplay_manager

func _enter_tree():
	gameplay_manager = get_tree().get_nodes_in_group("gameplay_manager")[0]
	print("tree entered")
	
func set_crate_time(n):
	if not (n>= 0 and n<= 3): return
	_timeID = n
	$model.set_surface_material(0,IDTable.material_crate_time[n])
	
func _on_Attacked():
	print("attacked: "+ str( _timeID))
	if (_timeID > 0):
		print("freeze bitch")
		gameplay_manager.event_time_freeze(_timeID)
	Destroy()

func _on_Jumped():
	_on_Attacked()
	
func _on_Exploded():
	_on_Attacked()
