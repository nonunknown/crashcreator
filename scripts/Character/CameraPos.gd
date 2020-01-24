extends Position3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var character:Character = get_node("../obj_Character")
# Called when the node enters the scene tree for the first time.
func _process(_delta):
	var pos = character.get_global_transform().origin
	translation = (Vector3(pos.x,pos.y+2,pos.z-2))

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
