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


func _physics_process(delta):

	var dir = Vector3()

 

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

 

	velocity = move_and_slide(velocity, Vector3(0,1,0))	