extends "res://scripts/gameplay/ItemCrate.gd"

func _ready():
	pass

func _on_Attacked():
	SpawnWumpa()
	Destroy()

func _on_Jumped():
	_on_Attacked()
	




func _on_btGenMesh_pressed():
	_on_Attacked()
