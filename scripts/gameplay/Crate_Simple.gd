extends Crate
class_name CrateSimple

func _on_Attacked():
	SpawnWumpa()
	Destroy()

func _on_Jumped():
	_on_Attacked()
	

func _on_Exploded():
	_on_Attacked()
