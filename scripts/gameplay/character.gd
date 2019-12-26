extends KinematicBody
class_name Character

signal increased_health(amt)
signal decreased_health(amt)


var is_grounded:bool = false
var velocity = Vector3()
var camera
var look_at = 0
var dashing = false
var health = 1
var obj_aku = preload("res://gameplay/obj_akuaku.tscn")
var aku:Node

export var gravity:float = -20
export var jump_force:int = 9
export var dash_duration:float = 1.5
export var acceleration:int = 9
export var de_acceleration:int = 10
export var speed:int = 4

export var power_double_jump:bool = false

onready var debug = get_parent().get_node("DebugText")
onready var anim:AnimationTree = get_node("AnimationTree")
onready var power:Power = Power.new()
onready var iventory:Iventory = Iventory.new()
onready var initial_speed:int = speed
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
	visible = false
	health = 0
	set_physics_process(false)
	
	
func ressurect():
	set_physics_process(true)
	health_increase(1)
	visible = true
	aku.visible = false

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
		
		0
func check_jump():
	if (Input.is_action_just_pressed("ui_jump") && jumps_actual >= 1):
		if (jumps > 1 && jumps_actual == jumps): #avoid spamming jump
			do_jump()
		elif (velocity.y < 1): do_jump() #velocity < 1 means falling
func check_dash():
	if (Input.is_action_just_pressed("cmd_dash") && !dashing):
		speed = initial_speed * 4
		dashing = true
		yield(get_tree().create_timer(dash_duration,false),"timeout")
		dashing = false
		speed = initial_speed
		

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

func health_increase(value:int=1):
	if (health + 1 <= 3):
		health += value
		aku._on_char_health_increased(health)

func health_decrease():
	if (health <= 0): return
	health -= 1
	if health <= 0:
		kill()
	else: 
		do_jump()
	aku._on_char_health_decreased(health)


func _ready():
	set_physics_process(true)
	aku = obj_aku.instance()
	aku.visible = false
	get_parent().call_deferred("add_child",aku)
	camera = get_viewport().get_camera().get_global_transform()
	power_init()

func _process(_delta):
	debug.set_text("velocityY",str(velocity.y))
	debug.set_text("jumpCount",str(jumps_actual))
	debug.set_text("health",str(health))
	debug.set_text("wumpa",str(iventory.wumpa))

func _physics_process(delta):
	check_grounded()
	move_calculation(delta)
	check_jump()
	check_dash()


	
func lerp_angle(from, to, weight):
	return from + short_angle_dist(from, to) * weight
		
func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference


func _on_Button2_pressed():
	ressurect()
	pass # Replace with function body.


func _on_Feet_area_entered(area):
	if (area.is_in_group("area_crate")):
		do_jump()
		var crate = area.get_parent()
		crate._on_Jumped()


func _on_Button3_pressed():
	health_decrease()
	pass # Replace with function body.
