extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var debug = get_node("../DebugText")
onready var character:Character = get_node("../obj_Character")
# Called when the node enters the scene tree for the first time.
func _process(_delta):
	var target:Vector3 = character.get_global_transform().origin
	look_at(target,Vector3.UP)

