extends KinematicBody
class_name Character

var is_grounded:bool = false
var velocity = Vector3()
var camera
var look_at = 0



export var gravity:float = -20
export var jump_force:int = 9
export var dash_duration:float = 1.5
export var acceleration:int = 9
export var de_acceleration:int = 10
export var speed:int = 4

export var power_double_jump:bool = false

onready var debug = get_parent().get_node("DebugText")
onready var anim = get_node("AnimationTree")
onready var power = Power.new()

#PowerStuff
var jumps:int = 1
var jumps_actual:int = 0


func power_init():
	if (power_double_jump):
		power.add(power.DOUBLE_JUMP)
		jumps = power.list[power.DOUBLE_JUMP].get_jumps()
	
	for i in power.list:
		power.list[i].start()
	
	jumps_actual = jumps

# Functions
func kill():
	set_physics_process(false)
	visible = false
	
func ressurect():
	set_physics_process(true)
	visible = true

var last_frame:bool = false
func check_grounded():
	if ($RayCast.is_colliding()): 
		is_grounded = true
		if (last_frame == false):
			jumps_actual = jumps
			last_frame = true
		
#		print($RayCast.get_collider())
	else: 
		is_grounded = false
		last_frame = false
		

func check_jump():
	if (Input.is_action_just_pressed("ui_jump") && jumps_actual >= 1):
		if (jumps > 1 && jumps_actual == jumps): #avoid spamming jump
			do_jump()
		elif (velocity.y < 1): do_jump() #velocity < 1 means falling
		

func do_jump():
	velocity.y = jump_force
	jumps_actual -= 1

func move_calculation(delta):
	var dir = Vector3()
	rotation.y = lerp_angle(rotation.y,look_at,0.25)
		
	if(Input.is_action_pressed("ui_up")):
		look_at = 0
		dir += -camera.basis[2]
		
	if(Input.is_action_pressed("ui_down")):
		look_at = -3
		dir += camera.basis[2]

	if(Input.is_action_pressed("ui_left")):
		look_at = 1.5

		dir += -camera.basis[0]

	if(Input.is_action_pressed("ui_right")):
		look_at = -1.5
		dir += camera.basis[0]
		
	dir.y = 0
	dir = dir.normalized()
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
	velocity = move_and_slide(velocity, Vector3(0,1,0),false,4,PI/4,false)	

func _ready():
	set_physics_process(true)
	camera = get_viewport().get_camera().get_global_transform()
	power_init()

func _physics_process(delta):
	debug.set_text("velocityY",str(velocity.y))
	debug.set_text("jumpCount",str(jumps_actual))
	check_grounded()
	move_calculation(delta)
	check_jump()


	
func lerp_angle(from, to, weight):
	return from + short_angle_dist(from, to) * weight
		
func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference

func _on_AreaFeet_body_entered(body):
	if (body.is_in_group("gp_crate")):
		print("colided crate")
		body._on_Jumped()
		velocity.y = 7
	pass # Replace with function body.


func _on_AreaBody_body_entered(body):
	if (body.is_in_group("gp_item")):
		body._on_Picked()
	pass # Replace with function body.

var process = false
func _on_btPlay_pressed():
	process = !process
	set_physics_process(process)
	pass # Replace with function body.


func _on_Feet_area_shape_entered(area_id, area, area_shape, self_shape):
	print(area)
	if (area.is_in_group("area_crate")):
		velocity.y = jump_force * 1.2
		area.get_parent().get_parent()._on_Jumped()
		
	pass # Replace with function body.


func _on_Body_area_entered(area):
	if (area.is_in_group("explosion")):
		kill()

func _on_Button2_pressed():
	ressurect()
	pass # Replace with function body.


func _on_Body_body_entered(body):
	if (body.is_in_group("gp_item")):
		
		pass
	pass # Replace with function body.
