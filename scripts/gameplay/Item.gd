extends Node
class_name Item

export var attackable:bool = false
var picked:bool = false


func _on_Picked(player):
	if !picked: picked = true
	else: return
	$sfx.play()
	$Area/CollisionShape.disabled = true
	_player_picked(player)
	self.visible = false
#	Utils.wait_for_seconds($sfx.stream.get_length())
#	queue_free()
	
func _on_Attacked():
	pass

func _player_picked(player):
	pass

func destroy():
	if (attackable):
		_on_Attacked()
	pass
