extends Enemy
class_name EnemyCowboy

export var obj_bullet:PackedScene
export var time_to_shoot:float = 1

func _ready():
	._ready()
	attack()
	
func attack():
	$model/AnimationPlayer.play("shoot",1)

func idle():
	$model/AnimationPlayer.play("idle",1)
	yield(get_tree().create_timer(time_to_shoot,false),"timeout")
	attack()

func shoot():
	var bullet:Bullet = obj_bullet.instance()
	get_parent().add_child(bullet)
	bullet.translation = translation
