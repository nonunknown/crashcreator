tool
extends Spatial

export var hide:bool = false
# Called when the node enters the scene tree for the first time.
func _process(delta):
	if hide:
		hide = false
		for child in get_children():
			child.visible = !child.visible
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
