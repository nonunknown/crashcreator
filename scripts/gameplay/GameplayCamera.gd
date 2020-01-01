extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var debug = get_node("../DebugText")
onready var character:Character = get_node("../obj_Character")
var rot = 0
var i = 0
var last_rot = 0
# Called when the node enters the scene tree for the first time.
func _process(_delta):
	var target:Vector3 = character.get_global_transform().origin
	look_at(target,Vector3.UP)

	if (Input.is_action_just_pressed("cam_right")):
		rot += .1
	elif (Input.is_action_just_pressed("cam_left")):
		rot -= .1
	elif (Input.is_action_just_pressed("cam_fw") and i+1 <= 2):
		i += 1
	elif (Input.is_action_just_pressed("cam_bk") and i-1 >= 0):
		i -= 1
		
	if (Input.is_action_just_pressed("ui_accept")):
		last_rot = transform.basis[i].y
		transform.basis[i].y = rot
	elif (Input.is_action_just_pressed("ui_cancel")):
		transform.basis[i].y = last_rot
	
	debug.set_text("cam_basis_id",str(i))
	debug.set_text("cam_basis_rot",str(rot))
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
