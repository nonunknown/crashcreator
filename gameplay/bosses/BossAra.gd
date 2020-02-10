extends Boss
class_name BossAra

enum STATE {IDLE,ATTACK,WIN,ATTACKED,NULL}

export var timer_1 = 1.3
export var timer_2 = .7
export var throw_1 = 20
export var throw_2 = 10
onready var dy = load("res://gameplay/items/obj_dynamite.tscn")
onready var actual_timer = timer_1
onready var timer = 10
onready var actual_throw = throw_1
onready var remaining_throw = actual_throw
onready var debug = get_tree().get_nodes_in_group("debug")[0]

var player_died = false
var machine:Utils.MachineManager
var animator:AnimationPlayer
var next_state:int = STATE.NULL
func _ready():
	._ready()
	animator = $AraBandicoot/AnimationPlayer
	
	machine = Utils.MachineManager.new()
	machine.register_state_array(self,[STATE.IDLE,STATE.ATTACK,STATE.WIN,STATE.ATTACKED,STATE.NULL],["idle","attack","win","attacked","null"])
#	animator.play("start")
	
	machine.change_state(next_state)

func play_cutscene():
	animator.playback_speed = 1
	animator.play("start")
	$voice_start.play()
	yield(get_tree().create_timer($voice_start.stream.get_length(),false),"timeout")
	next_state = STATE.IDLE
	_on_animation_finished("null")

func _update(delta):
	debug.set_text("timer",str(timer))
	debug.set_text("remaining",str(remaining_throw))
	debug.set_text("state",str(STATE.keys()[machine.get_current_state()]))
	debug.set_text("health",health)
	look_at(character.translation,Vector3.UP)
	if !player_died:
		timer -= delta
	machine.machine_update()
	pass

func st_init_null():
#	animator.play("start")
	pass

func st_update_null():
	pass

func st_exit_null():
	pass

func st_init_idle():
	print("idle")
	attacked = false
	animator.playback_speed = 1.5
	animator.play("idle-loop")
	yield(get_tree().create_timer(1,false),"timeout")
	_on_animation_finished("idle-loop")
	pass

func st_update_idle():
	if timer <=0:
		timer = actual_timer
		next_state = STATE.ATTACK
	pass

func st_exit_idle():
	pass

func st_init_attack():
	print("attack")
	animator.playback_speed = 2
	animator.play("throw")
	var r = rand_range(0,1)
	if r > .6:
		$voice_attack.play()
	if remaining_throw > 0:
		throw_dynamite()
		remaining_throw -= 1
	else:
		if actual_throw == throw_1:
			timer = 5
			actual_throw = throw_2
			remaining_throw = actual_throw
	yield(get_tree().create_timer(.3,false),"timeout")
	next_state = STATE.IDLE
	_on_animation_finished("attack")
	pass

func st_update_attack():
	pass

func st_exit_attack():
	print("exitattack")
	pass

func st_init_win():
	animator.playback_speed = 1.5
	animator.play("win-loop")
	$voice_yata.play()
	
	pass

func st_update_win():
	pass

func st_exit_win():
	pass

func st_init_attacked():
	animator.playback_speed = 1
	animator.play("jump-ground")
	$voice_hit2.play()
	if health == 3:
		actual_timer = timer_2
		
	yield(get_tree().create_timer(.3,false),"timeout")
	next_state = STATE.IDLE
	_on_animation_finished("attacked")
	pass

func st_update_attacked():
	pass
	
func st_exit_attacked():
	pass
func throw_dynamite():
	var i = dy.instance()
	get_parent().add_child(i)
	i.translation = translation
	var target_pos = character.get_node("PosFuture").get_global_transform().origin
	var x = target_pos.x
	var z = target_pos.z
	i.add_central_force(Vector3(50 * x,400,50 * z))

func say_start():
	$voice_start.play()

func _on_player_died():
	player_died = true
	next_state = STATE.WIN

func _on_game_restart():
	._on_game_restart()
	translation = initial_pos
	player_died = false
	actual_timer = timer_1
	timer = 5
	actual_throw = throw_1
	remaining_throw = actual_throw
	next_state = STATE.IDLE
	_on_animation_finished("win-loop")

var attacked:bool = false
func _on_attacked():
	if attacked: return
	attacked = true
	._on_attacked()
	next_state = STATE.ATTACKED

func _on_Area_area_entered(area):
	_on_attacked()


func _on_animation_finished(anim_name):
	print("finished: "+anim_name)
	print("next state: "+str(STATE.keys()[next_state]))
	machine.change_state(next_state)
	pass # Replace with function body.
