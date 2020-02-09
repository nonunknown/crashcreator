extends Boss
class_name BossAra

enum STATE {IDLE,ATTACK,WIN,ATTACKED}

export var timer_1 = 1.3
export var timer_2 = .7
export var throw_1 = 20
export var throw_2 = 10
onready var dy = load("res://gameplay/items/obj_dynamite.tscn")
onready var actual_timer = timer_1
onready var timer = actual_timer
onready var actual_throw = throw_1
onready var remaining_throw = actual_throw
var player_died = false
var machine:Utils.MachineManager
var animator:AnimationPlayer

func _ready():
	._ready()
	animator = $AraBandicoot/AnimationPlayer
	
	machine = Utils.MachineManager.new()
	machine.register_state_array(self,[STATE.IDLE,STATE.ATTACK,STATE.WIN,STATE.ATTACKED],["idle","attack","win","attacked"])
	machine.change_state(STATE.IDLE)

func _update(delta):
	look_at(character.translation,Vector3.UP)
	if !player_died:
		timer -= delta
	machine.machine_update()
	pass


func st_init_idle():
	animator.playback_speed = 1.5
	animator.play("idle-loop")
	
	pass

func st_update_idle():
	if timer <=0:
		timer = actual_timer
		machine.change_state(STATE.ATTACK)
	pass

func st_exit_idle():
	pass

func st_init_attack():
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
#	yield(get_tree().create_timer(1,false),"timeout")
	machine.change_state(STATE.IDLE)
	pass

func st_update_attack():
	pass

func st_exit_attack():
	pass

func st_init_win():
	animator.playback_speed = 1.5
	$voice_laught.play()
	animator.play("win-loop")
	yield(get_tree().create_timer(1.3,false),"timeout")
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
		
	machine.change_state(STATE.IDLE)
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

func _on_player_died():
	player_died = true
	machine.change_state(STATE.WIN)

func _on_game_restart():
	player_died = false
	actual_timer = timer_1
	timer = 5
	actual_throw = throw_1
	remaining_throw = actual_throw
	machine.change_state(STATE.IDLE)

func _on_attacked():
	._on_attacked()
	health -= 1
	machine.change_state(STATE.ATTACKED)

func _on_Area_area_entered(area):
	_on_attacked()
