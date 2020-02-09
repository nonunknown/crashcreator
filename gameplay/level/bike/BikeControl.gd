extends RigidBody


# Declare member variables here. Examples:
# var turn = 2
# var b = "text"


# Called when the node enwters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var turn = 0
var speed_percentage:float = 0
var speed:float = 0
var acceleration:float = .02
var deacceleration:float = .01
var gravity:float = -20
onready var model:Spatial = $model
onready var guidon:Spatial = $model/guidon
onready var ray:RayCast = $RayCast
var dir:Vector3

func _physics_process(delta):
	dir = Vector3.ZERO
	dir.y = gravity * delta
	print(linear_velocity)
	if Input.is_action_just_pressed("ui_accept"):
#		add_force(get_global_transform().basis.x  * 1000,Vector3.ZERO)
#		apply_impulse(Vector3.ZERO,get_global_transform().basis.x  * 1500)
		pass
#	if Input.is_action_pressed("ui_up") and linear_velocity.length() < 100:
#		add_force(get_global_transform().basis.z * 100, get_global_transform().origin)
#		apply_central_impulse(get_global_transform().basis.x * 1)
	
#	if linear_velocity.z > 0 and abs(linear_velocity.x ) < 40:
	speed_percentage = abs(linear_velocity.z / 100)
	print($RayCast.is_colliding())
	
	dir += Vector3(int( Input.is_action_pressed("ui_left") ) + ( int (Input.is_action_pressed("ui_right") ) * -1 ),0,int(Input.is_action_pressed("ui_up")))
	print(dir.x)
#	if dir.x < -.1 and dir.x > .1:
#			apply_central_impulse(get_global_transform().basis.z * dir * 4)
	
	
	

func _integrate_forces(_state):
	var factor = get_factor()
	prints(str(dir.z),"factor: ",str(factor))
	speed = lerp(speed, dir.z * 100,factor)
	if linear_velocity.length() < 100:
		linear_velocity +=  guidon.transform.basis.x + Vector3(0,0,speed)
		
		pass
	turn =  lerp( turn, dir.x * 40,.1)
	print(turn)
	guidon.rotation_degrees.y = lerp(guidon.rotation_degrees.y, dir.x * (20 * speed_percentage),.2)
	if linear_velocity.length() > 20:
		model.rotation_degrees.x = lerp(model.rotation_degrees.x,-dir.x * (35 * speed_percentage),.1)
	
		
	if linear_velocity.length() > 40:
		linear_velocity.x = lerp(linear_velocity.x,turn * speed_percentage,.2)
	else: linear_velocity.x = lerp(linear_velocity.x,0,.5)

func get_factor() -> float:
	if (dir.z > .5): return acceleration
	else: return deacceleration
	
