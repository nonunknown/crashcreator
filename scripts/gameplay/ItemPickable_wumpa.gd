extends "res://scripts/gameplay/ItemPickable.gd"


func picked_overload():
	#TODO: Add to players wumpa count
	pass
	

func _on_Area_body_entered(body):
	if (body.collision_layer == 2):
		_on_Picked()
	pass # Replace with function body.



func _on_Area_area_entered(area):
	print("area of wumpa")
	if (area.collision_layer == 128):
		print("explosin")

		self.visible = false
	pass # Replace with function body.
