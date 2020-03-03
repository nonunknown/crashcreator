extends Spatial
class_name Bullet

var target:Vector3

func _ready():
	target = Utils.get_player().get_global_transform().origin
	yield(get_tree().create_timer(.4,false),"timeout")
	queue_free()

func move() -> void:
	look_at(target,Vector3.UP)
	translation -= get_global_transform().basis.z * .3
	pass

func _process(delta):
	move()
