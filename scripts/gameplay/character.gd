extends KinematicBody

var gravity = -12

var velocity = Vector3()

var camera

const SPEED = 6

const ACCELERATION = 3

const DE_ACCELERATION = 5



func _ready():
	
	# Called every time the node is added to the scene.

	# Initialization here

	# pass

	camera = get_node("../Camera").get_global_transform()


#func _process(delta):

#	# Called every frame. Delta is time since last frame.

#	# Update game logic here.

#	pass


var look_at = 0

func _physics_process(delta):

	var dir = Vector3()
	rotation.y = lerp_angle(rotation.y,look_at,0.25)
	print(rotation.y)
		
	if(Input.is_action_pressed("ui_up")):
		look_at = -3
		
		dir += -camera.basis[2]

	if(Input.is_action_pressed("ui_down")):
		look_at = 0
		dir += camera.basis[2]

	if(Input.is_action_pressed("ui_left")):
		look_at = -1.5

		dir += -camera.basis[0]

	if(Input.is_action_pressed("ui_right")):
		look_at = 1.5
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
		
		velocity.y = 6.2


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
