extends Item
class_name ItemLife

func _player_picked(player:Character):
	player.iventory.add_life(1)
	

func _on_Area_area_entered(area):
	if (area.collision_layer == Utils.MASK.Player_Area):
		print("got life")
		_on_Picked(area.get_parent())
	pass # Replace with function body.
