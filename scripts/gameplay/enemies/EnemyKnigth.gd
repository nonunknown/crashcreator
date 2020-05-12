extends Enemy
class_name EnemyKnight

var machine:StateMachine
var animator:AnimationPlayer
var blend_time:float = 0.1
enum STATE {IDLE,ATTACK}
func _ready():
	machine = StateMachine.new(self)
	animator = $AnimationPlayer
	machine.register_state_array([STATE.IDLE,STATE.ATTACK],["idle","attack"])
	machine.change_state(STATE.IDLE)
	
func st_init_idle():
	
	animator.play("idle",blend_time)
	
	animator.playback_speed = 1
	$sfx_force.play()
	yield(get_tree().create_timer(2,false),"timeout")
	machine.change_state(STATE.ATTACK)
	pass

func st_update_idle():
	pass

func st_exit_idle():
	pass

func st_init_attack():
	animator.play("attack",blend_time)
	animator.playback_speed = 2
	pass

func st_update_attack():
	pass

func st_exit_attack():
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if machine.state_is(STATE.ATTACK):
		machine.change_state(STATE.IDLE)
	pass # Replace with function body.
