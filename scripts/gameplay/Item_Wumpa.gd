extends Item
class_name ItemWumpa

func _player_picked(player:Character):
	if (player == null): return
	player.iventory.add_wumpa(1)
	pass

func _on_Area_area_entered(area):
	if picked: return
	print("area of wumpa")
	print("area: "+str(area.collision_layer))
	print(str(area))
	if (area.collision_layer == Utils.MASK.Player_Area):
		print("player entered")
		var player = area.get_parent()
		_on_Picked(player)
	if (area.collision_layer == 128):
		print("explosin")

		self.visible = false
	pass # Replace with function body.
