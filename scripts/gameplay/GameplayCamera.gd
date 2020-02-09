extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var debug = get_node("../DebugText")
export var simulate_ready = true
var character:Character = null
# Called when the node enters the scene tree for the first time.
func _ready():
	if simulate_ready:
		_gameplay_ready()

func _gameplay_ready():
	print("cam: player"+str(character))
	character = Utils.get_player()
	
func _process(_delta):
	if character == null: return
	var target:Vector3 = character.get_global_transform().origin
	look_at(target+Vector3(0,2,0),Vector3.UP)
	translation = lerp(translation,character.cam_target.translation,0.03)

