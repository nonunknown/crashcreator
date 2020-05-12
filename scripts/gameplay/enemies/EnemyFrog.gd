extends Enemy
class_name EnemyFrog

var machine:StateMachine 
var animator:AnimationPlayer
var blend_time:float = 0.1
var ray_position:RayCast
var look_target:Vector3
var area_move:Area
enum STATE {IDLE,JUMP}
func _ready():
	machine = StateMachine.new(self)
	animator = $AnimationPlayer
	machine.register_state_array([STATE.IDLE,STATE.JUMP],["idle","jump"])
	machine.change_state(STATE.IDLE)
	config_ai()

func _update(delta):
	machine.machine_update()

func config_ai():
	ray_position = get_node("AreaMove/RayPosition")
	area_move = $AreaMove
	call_deferred("remove_child",area_move)
	get_parent().call_deferred("add_child",area_move)

func prepare_jump():
	var target = ray_position.get_global_transform().origin#Utils.get_player().translation
	look_at(target,Vector3.UP)
	machine.change_state(STATE.JUMP)

func st_init_idle():
	animator.play("idle",blend_time)
	animator.playback_speed = 1
	yield(get_tree().create_timer(.5,false),"timeout")
	prepare_jump()
	pass

func st_update_idle():
	pass

func st_exit_idle():
	pass

func st_init_jump():
	animator.play("jump",blend_time)
	do_jump()
	yield(get_tree().create_timer(.5,false),"timeout")
	machine.change_state(STATE.IDLE)
	
	pass

func st_update_jump():
	move_forward()
	pass

func st_exit_jump():
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	pass # Replace with function body.
