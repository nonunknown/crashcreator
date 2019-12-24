extends Node

func _on_Picked():
	$sfx.play()
	self.visible = false
