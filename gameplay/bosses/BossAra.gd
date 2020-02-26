extends Boss
class_name BossAra

enum STATE {IDLE,ATTACK,WIN,ATTACKED,NULL,WAIT}

export var timer_1 = 1.1
export var timer_2 = .5
export var throw_1 = 15
export var throw_2 = 8
onready var dy = load("res://gameplay/items/obj_dynamite.tscn")
onready var actual_timer = timer_1
onready var timer = 10
onready var actual_throw = throw_1
onready var remaining_throw = actual_throw
onready var debug = get_tree().get_nodes_in_group("debug")[0]

var player_died = false
var machine:Utils.MachineManager
var animator:AnimationPlayer
var next_state:int = STATE.IDLE
func _ready():
	._ready()
	animator = $AraBandicoot/AnimationPlayer
	
	machine = Utils.MachineManager.new()
	machine.register_state_array(self,[STATE.IDLE,STATE.ATTACK,STATE.WIN,STATE.ATTACKED,STATE.NULL,STATE.WAIT],["idle","attack","win","attacked","null","wait"])
	machine.change_state(next_state)

func play_cutscene():
	animator.playback_speed = 1
	animator.play("start")
	$voice_start.play()
	yield(get_tree().create_timer($voice_start.stream.get_length(),false),"timeout")
	machine.change_state(STATE.IDLE)

func _update(delta):
	debug.set_text("timer",str(timer))
	debug.set_text("remaining",str(remaining_throw))
	debug.set_text("state",str(STATE.keys()[machine.get_current_state()]))
	debug.set_text("health",health)
	
	look_at(character.translation,Vector3.UP)
	rotation_degrees = Vector3(0,rotation_degrees.y,0)
	timer -= delta
	machine.machine_update()
	pass

func st_init_null():
	pass

func st_update_null():
	pass

func st_exit_null():
	pass

var check_level = true
func st_init_idle():
	animator.playback_speed = 1
	animator.play("idle-loop",0.1)
	
	if check_level == false: return
	match(health):
		4:
			timer = timer_1
			remaining_throw = throw_1
			actual_timer = timer_1
		3:
			timer = timer_2
			remaining_throw = throw_2
			actual_timer = timer_2
		2,1:
			timer = timer_2
			remaining_throw = throw_1
			actual_timer = timer_2
			
	check_level = false
	if player_died:
		player_died = true
		timer = 3
	pass

func st_update_idle():
	if timer < 0 and remaining_throw > 0:
		machine.change_state(STATE.ATTACK)
		timer = actual_timer
		remaining_throw -= 1
	elif remaining_throw <= 0:
		machine.change_state(STATE.WAIT)
	pass

func st_exit_idle():
	pass

func st_init_attack():
	animator.playback_speed = 1.5
	animator.play("throw",0.1)
	throw_dynamite()
	timer = 1
	pass

func st_update_attack():
	if timer < 0:
		timer = 1
		machine.change_state(STATE.IDLE)
	pass

func st_exit_attack():
	pass

func st_init_win():
	animator.playback_speed = 1.5
	animator.play("win-loopṕ")
	$voice_laught.play()
	pass

func st_update_win():
	if animator.current_animation != "win-loop":
		animator.play("win-loop")
	pass

func st_exit_win():
	pass

func st_init_attacked():
	animator.play("jump-ground",0.1)
	$voice_hit1.play()
	$sfx_hit.play()
	timer = 4
	health -= 1
	check_level = true
	pass

func st_update_attacked():
	if timer < 0:
		timer = 5
		machine.change_state(STATE.IDLE)
		
	pass
	
func st_exit_attacked():
	attacked = false
	event_gameplay.manager_gameplay.trigger_boss_wait(false)
	emit_signal("health_decreased",health)
	pass

func st_init_wait():
	animator.play("eat-loop",0.1)
	$voice_yata.play()
	event_gameplay.manager_gameplay.trigger_boss_wait(true)
	timer = 4 #wait for player attack time
	pass

func st_update_wait():
	if timer <= 0:
		check_level = true
		machine.change_state(STATE.IDLE)
	pass
	
func st_exit_wait():
	if !attacked:
		event_gameplay.manager_gameplay.trigger_boss_wait(false)
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
	machine.change_state(STATE.WIN)

func _on_game_restart():
	._on_game_restart()
	health = initial_health
	timer = timer_1+3
	remaining_throw = throw_1
	check_level = true
	machine.change_state(STATE.IDLE)

var attacked:bool = false
func _on_attacked():
	if !attacked:
		attacked = true
		machine.change_state(STATE.ATTACKED)
	pass

func _on_Area_area_entered(area):
	_on_attacked()
