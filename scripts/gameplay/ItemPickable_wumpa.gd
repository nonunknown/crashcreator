extends "res://scripts/gameplay/ItemPickable.gd"


func _on_Picked():
	print("wumpa")
	$sfx.play()
	self.visible = false


func _on_Area_body_entered(body):
	_on_Picked()
	pass # Replace with function body.


func _on_sfx_finished():
	self.queue_free()
	pass # Replace with function body.
