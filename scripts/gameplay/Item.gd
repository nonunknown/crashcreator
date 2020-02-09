extends Node
class_name Item

export var attackable:bool = false
var picked:bool = false


func revive():
	picked = false
	$Area/CollisionShape.disabled = false
	self.visible = true

func _on_Picked(player):
	if !picked: picked = true
	else: return
	if $fx_collect != null:
		$fx_collect.emitting = true
	$sfx.play()
	
	$Area/CollisionShape.disabled = true
	_player_picked(player)
	if $model != null:
		$model.visible = false
#	Utils.wait_for_seconds($sfx.stream.get_length())
#	queue_free()
	
func _on_Attacked():
	pass

func _player_picked(_player):
	pass

func destroy():
	if (attackable):
		_on_Attacked()
	pass
