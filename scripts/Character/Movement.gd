class_name Movement

var character = null

func _init(_target):
	character = _target
	camera = character.camera
	initial_gravity = gravity
	initial_speed = speed

export var gravity:float = -20
export var jump_force:int = 9
export var acceleration:int = 20
export var de_acceleration:int = 10
export var speed:int = 4

var camera:Transform
var dir = Vector3()
var last_pos:Vector3
var last_dir:Vector3
var velocity = Vector3()
var is_grounded:bool = false
var look_at = 0
var can_move = true
var initial_gravity:float
var disable_jump = false
var last_frame = false
var ray_to_ground = false
onready var initial_speed:int

var velocity_median:float setget ,get_velocity_median

func get_velocity_median():
	return (abs(velocity.x) + abs(velocity.z)) * 0.5
	

func move_calculation(delta):
	looking_system()
	check_grounded()
	if (!can_move):
		last_dir = dir
	
	
	if can_move:
		dir = Vector3.ZERO
		
		if(Input.is_action_pressed("ui_up")):
			
			dir += -camera.basis[2]
			
		if(Input.is_action_pressed("ui_down")):
			dir += camera.basis[2]
			
		if(Input.is_action_pressed("ui_left")):
			dir += -camera.basis[0]
	
		if(Input.is_action_pressed("ui_right")):
			dir += camera.basis[0]
		
	dir.y = 0
	dir = dir.normalized()
	last_dir = dir
	last_pos = character.get_transform().origin
	if (Input.is_action_just_pressed("ui_jump")):
		jump()
	if !character.is_on_floor():
		velocity.y += delta * gravity
	var hv = velocity
	hv.y = 0
	var new_pos = dir * speed
	var accel = de_acceleration
	if (dir.dot(hv) > 0):
		accel = acceleration
	hv = hv.linear_interpolate(new_pos, accel * delta)
	velocity.x = hv.x
	velocity.z = hv.z
	velocity = character.move_and_slide(velocity, Vector3(0,-gravity,0).normalized(),true)



var new_angle:float = 0
var new_dir:Vector3 = Vector3.ZERO

func looking_system():
	
	if (dir != Vector3.ZERO):
		new_dir = dir
	var angle:float = atan2(new_dir.x,new_dir.z)
	new_angle = lerp_angle(new_angle,angle,.25)
	var deg = rad2deg(new_angle)
	character.rotation_degrees.y = deg

func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference

var last_vy:float = 0
func check_grounded():
#	print(velocity.y)
	if ( velocity.y < 0.5 && velocity.y > -.5 ) and ray_to_ground:
		is_grounded = true
	else:
		is_grounded = false #character.is_on_floor()
		last_vy = velocity.y
	
	if is_grounded:
		if (last_frame == false):
			character.jumps_actual = character.jumps
			last_frame = true
	else:
		last_frame = false
		
func check_jump():
	pass
	# onready var machine:CharacterMachine = CharacterMachine.new(self)
	
	if (disable_jump): return
	if (Input.is_action_just_pressed("ui_jump") && character.jumps_actual >= 1):
		if (character.jumps > 1 && character.jumps_actual == character.jumps): #avoid spamming jump
			jump()
		elif (velocity.y < 1): jump() #velocity < 1 means falling

func jump():
	velocity.y = jump_force
	character.jumps_actual -= 1
