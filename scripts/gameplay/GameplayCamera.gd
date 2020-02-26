extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var debug = get_node("../DebugText")
export var simulate_ready = true
export var cam_type_side:bool = false
export var offset:Vector3
var character:Character = null
var update_func:FuncRef
# Called when the node enters the scene tree for the first time.
func _ready():
	if simulate_ready:
		_gameplay_ready()

func _gameplay_ready():
	print("cam: player"+str(character))
	character = Utils.get_player()
	if cam_type_side:
		update_func = funcref(self,"update_cam_side")
	else:
		update_func = funcref(self,"update_cam")
	
	
func _process(_delta):
	update_func.call_func()

func update_cam():
	if character == null: return
	var target:Vector3 = character.get_global_transform().origin
	look_at(target+Vector3(0,2,0),Vector3.UP)
	translation = lerp(translation,character.cam_target.translation,0.03)

func update_cam_side():
#	var target:Vector3 = character.get_global_transform().origin
#	look_at(target+Vector3(0,2,0),Vector3.UP)
	translation = lerp(translation,character.cam_target.translation + offset,0.07)
