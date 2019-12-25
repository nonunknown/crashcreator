extends Node

export var attackable:bool = false

var picked:bool = false

func _on_Picked():
	if !picked: picked = true
	else: return
	$sfx.play()
	self.visible = false

func _on_Attacked():
	pass

func destroy():
	if (attackable):
		_on_Attacked()
	pass
