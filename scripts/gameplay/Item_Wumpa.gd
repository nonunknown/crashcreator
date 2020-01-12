extends Item
class_name ItemWumpa

func _player_picked(player:Character):
	player.iventory.add_wumpa(1)
	pass

func _on_Area_area_entered(area):
	print("area of wumpa")
	if (area.collision_layer == 128):
		print("explosin")

		self.visible = false
	pass # Replace with function body.
