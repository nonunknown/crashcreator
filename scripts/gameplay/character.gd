extends KinematicBody
class_name Character

var gravity = -20
var jump_force = 9

var velocity = Vector3()

var camera

const SPEED = 4

const ACCELERATION = 9

const DE_ACCELERATION = 10


onready var debug = get_parent().get_node("DebugText")

# Functions
func kill():
	set_physics_process(false)
	visible = false
	
func ressurect():
	set_physics_process(true)
	visible = true

func _ready():
	debug.add_text(1)
	
	
	set_physics_process(true)

	camera = get_viewport().get_camera().get_global_transform()


#func _process(delta):

#	# Called every frame. Delta is time since last frame.

#	# Update game logic here.

#	pass
onready var anim = get_node("AnimationTree")
var look_at = 0
func _physics_process(delta):
	debug.set_text(1,"velocityY: "+str(velocity.y))
	if ($RayCast.is_colliding()): 
		is_grounded = true
#		print($RayCast.get_collider())
	else: 
		is_grounded = false
			
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

 

	var new_pos = dir * SPEED

	var accel = DE_ACCELERATION

 

	if (dir.dot(hv) > 0):

		accel = ACCELERATION

 

	hv = hv.linear_interpolate(new_pos, accel * delta)

 

	velocity.x = hv.x

	velocity.z = hv.z


	velocity = move_and_slide(velocity, Vector3(0,1,0),false,4,PI/4,false)	
	if (Input.is_action_just_pressed("ui_jump")):
		velocity.y = jump_force

var is_grounded:bool = false
	
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
	print("entered")
	if (area.is_in_group("explosion")):
		kill()
	pass # Replace with function body.


func _on_Button2_pressed():
	ressurect()
	pass # Replace with function body.
