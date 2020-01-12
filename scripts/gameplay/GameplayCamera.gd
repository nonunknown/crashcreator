extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var debug = get_node("../DebugText")
var character:Character
# Called when the node enters the scene tree for the first time.
func _ready():
	print("cam: player"+str(character))
	character = get_node("../obj_Character")

func _process(_delta):
	var target:Vector3 = character.get_global_transform().origin
	look_at(target+Vector3(0,2,0),Vector3.UP)
	translation = lerp(translation,target-Vector3(0,-3,-4),.01)

