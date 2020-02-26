extends KinematicBody
class_name EnemyCow

export var max_speed:float = 2

func _physics_process(delta):
	move_and_slide(Vector3.FORWARD * max_speed)
