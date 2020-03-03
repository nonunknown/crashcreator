extends KinematicBody
class_name KinematicCharacter

export var gravity:float = -20
export var accel = 30
export var deaccel = 30
export var max_speed = 3.1
export var jump_force = 14
export var playable:bool = false
export var air_idle_deaccel = false
export var keep_jump_inertia = true
export var can_move_on_air = true
export var is_machine_controlled:bool = true
export var is_global_axis_controlled:bool = false
var camera:Transform
var initial_pos:Vector3
var is_grounded:bool = false
var virtual_hspeed:float = 0
var facing_dir = Vector3(1, 0, 0)
var dir:Vector3 = Vector3()
var movement_dir = Vector3()
var jumping = false
var linear_velocity=Vector3()
var jump_attempt = false
var extra_jump_force:float = 1
var inputs:Array = []
var last_hspeed:float = 0.0 
var input_update:FuncRef

onready var initial_maxspeed:float = max_speed

func _ready():
	initial_pos = translation
	if !is_machine_controlled:
		if is_global_axis_controlled:
			input_update = funcref(self,"input_update_axis")
		else:
			input_update = funcref(self,"input_update_normal")
	else:
		input_update = funcref(self,"input_update_machine")
		
	
func _process(_delta):
	if playable:
		camera = get_viewport().get_camera().get_global_transform()
	pass

func input_update_machine(dir,_cam_xform):
	dir = Vector3.ZERO
	return dir

func input_update_normal(dir,cam_xform):
	inputs = [Input.is_action_pressed("ui_up"),
	Input.is_action_pressed("ui_down"),
	Input.is_action_pressed("ui_left"),
	Input.is_action_pressed("ui_right")
	]
	
	if !is_machine_controlled:
		if inputs[0]:
			dir += -cam_xform.basis[2]
		if inputs[1]:
			dir += cam_xform.basis[2]
		if inputs[2]:
			dir += -cam_xform.basis[0]
		if inputs[3]:
			dir += cam_xform.basis[0]
	return dir

func input_update_axis(dir,_cam_xform):
	inputs = [Input.is_action_pressed("ui_up"),
	Input.is_action_pressed("ui_down"),
	Input.is_action_pressed("ui_left"),
	Input.is_action_pressed("ui_right")
	]
	if inputs[0]:
		dir += Vector3.RIGHT
	if inputs[1]:
		dir += Vector3.LEFT
	if inputs[2]:
		dir += Vector3.FORWARD
	if inputs[3]:
		dir += Vector3.BACK
	return dir

func adjust_facing(p_facing, p_target, p_step, p_adjust_rate, current_gn):
	var n = p_target # Normal
	var t = n.cross(current_gn).normalized()
	 
	var x = n.dot(p_facing)
	var y = t.dot(p_facing)
	
	var ang = atan2(y,x)
	
	if abs(ang) < 0.001: # Too small
		return p_facing
	
	var s = sign(ang)
	ang = ang * s
	var turn = ang * p_adjust_rate * p_step
	var a
	if ang < turn:
		a = ang
	else:
		a = turn
	ang = (ang - a) * s
	
	return (n * cos(ang) + t * sin(ang)) * p_facing.length()

func _physics_process(delta):

	var lv = linear_velocity
	var g = Vector3(0, gravity, 0)

	lv += g * delta # Apply gravity

	var up = -g.normalized() # (up is against gravity)
	var vv = up.dot(lv) # Vertical velocity
	var hv = lv - up * vv # Horizontal velocity

	var hdir = hv.normalized() # Horizontal direction
	var hspeed = hv.length() # Horizontal speed

	dir = Vector3.ZERO # Where does the player intend to walk to

	var cam_xform = get_viewport().get_camera().get_global_transform()
	
	dir = input_update.call_funcv([dir,cam_xform])
	
	var target_dir = (dir - up * dir.dot(up)).normalized()
	
	if can_move_on_air or is_grounded:
#		var sharp_turn = hspeed > 0.1 and rad2deg(acos(target_dir.dot(hdir))) > 140
		if dir.length() > 0.1 :#and !sharp_turn:
			if hspeed > 0.001:
				hdir = Vector3(dir.x,0,dir.z) * max_speed/hspeed#adjust_facing(hdir, target_dir, delta, 1.0 / hspeed * turn_speed, up)
				facing_dir = hdir
			else:
				hdir = target_dir
			
			if hspeed < max_speed:
				hspeed += accel * delta
			elif hspeed > max_speed:
				hspeed = max_speed
		else:
			hspeed -= deaccel * delta
			if hspeed < 0:
				hspeed = 0
		hv = hdir * hspeed
		
#		if (vv < -1 or vv > 1) && is_grounded: #maintain the samespeed when going down or up on slopes
#			hspeed = max_speed
		
		last_hspeed = hspeed
		adjust_direction()

	if is_grounded:
		if not jumping and jump_attempt:
			vv = jump_force * extra_jump_force
			jumping = true
			jump_attempt = false
			extra_jump_force = 1
	else:
		
		# var hs
		if dir.length() > 0.1:
			hv += target_dir * (accel * 0.2) * delta
			if (hv.length() > max_speed):
				hv = hv.normalized()*max_speed
		else:
			if air_idle_deaccel:
				hspeed = hspeed - (deaccel * 0.2) * delta
				if hspeed < 0:
					hspeed = 0
				hv = hdir * hspeed
	
	if  ( jumping and vv < 0 ) or is_grounded:
		jumping = false
	
	lv = hv + up*vv
	virtual_hspeed = hspeed
	if is_grounded:
		movement_dir = lv
	
	linear_velocity = move_and_slide(lv,-g.normalized(),true)


func inputs_any_pressed() -> bool:
	for i in inputs:
		if i == true:
			return true
	return false

var new_angle:float = 0
var new_dir:Vector3 = Vector3.ZERO
func adjust_direction():
	if (dir != Vector3.ZERO):
		new_dir = dir
	var angle:float = atan2(new_dir.x,new_dir.z)
	new_angle = lerp_angle(new_angle,angle,.25)
	var deg = rad2deg(new_angle)
	rotation_degrees.y = deg

func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference

func do_jump():
	jump_attempt = true
	
	pass

func move_forward():
	dir = -get_global_transform().basis.z

func move_backward():
	dir = get_global_transform().basis.z
