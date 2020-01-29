extends KinematicBody
class_name Character

signal increased_health(amt)
signal decreased_health(amt)


var is_grounded:bool = false
var velocity = Vector3()
var camera
var look_at = 0
var dashing = false
var attacking:bool = false
var health = 1
var obj_aku = preload("res://gameplay/obj_akuaku.tscn")
var aku:Node
var can_move = true
var disable_jump = false
var manager_gameplay:ManagerGameplay = null
var is_on_slope:bool = false

export var use_debugger:bool = false
export var blend_time:float = .1
export var gravity:float = -20
export var jump_force:int = 9
export var dash_duration:float = 1.5
export var acceleration:int = 20
export var de_acceleration:int = 10
export var speed:int = 4

export var power_double_jump:bool = false

var debug = null
#onready var anim:AnimationTree = get_node("AnimationTree")
onready var power:Power = Power.new()
onready var iventory:Iventory = Iventory.new()
onready var initial_speed:int = speed
onready var input_move_keys:Array
onready var animator:AnimationPlayer = get_node("crashbandicoot/AnimationPlayer")
onready var initial_gravity:float = gravity
onready var twist_crash:Node = $crashbandicoot/twistcrash

#PowerStuff
var jumps:int = 1
var jumps_actual:int = 0
#State Machine
enum STATE {IDLE,WALK,RUN,JUMP,CROUCH,DASH,JUMP_MOVE,BODY_SLAM,FALLING,ATTACK,PORTAL}
var machine:Dictionary = {
	state=null,
	funcs={
		init={},
		update={},
		exit={}
		}
	}
		
func insert_state_info(state_const:int,name:String,has_init:bool=true,has_exit:bool=false):
	if (has_init):
		machine.funcs.init[state_const] = funcref(self,"st_init_"+name)
	machine.funcs.update[state_const] = funcref(self,"st_update_"+name)
	if (has_exit):
		machine.funcs.exit[state_const] = funcref(self,"st_exit_"+name)
	
func register_machine():
	insert_state_info(STATE.IDLE,"idle")
	insert_state_info(STATE.WALK,"walk")
	insert_state_info(STATE.JUMP,"jump")
	insert_state_info(STATE.JUMP_MOVE,"jump_move")
	insert_state_info(STATE.PORTAL,"portal")
	insert_state_info(STATE.RUN,"run",true,true)
	insert_state_info(STATE.BODY_SLAM,"body_slam",true,true)
	insert_state_info(STATE.CROUCH,"crouch",true,true)
	insert_state_info(STATE.DASH,"dash",true,true)
	insert_state_info(STATE.FALLING,"falling",true,true)
	insert_state_info(STATE.ATTACK,"attack",true,true)
	change_state(STATE.IDLE)
	pass
	
func machine_update():
	machine.funcs.update[machine.state].call_func()
	
func change_state(to):
	if machine.funcs.exit.has(machine.state):
		machine.funcs.exit[machine.state].call_func()
	machine.state = to
	if machine.funcs.init.has(machine.state):	
		machine.funcs.init[to].call_func() #call the init function of next states
#	using_state_queue = false
	
#var using_state_queue:bool = false
#func change_state_async(to):
#	using_state_queue = true
#	yield(get_tree().create_timer(current_animation_length(),true),"timeout")
#	change_state(to)

func cd_any() -> bool:
	if cd_idle(): return true
	elif cd_spin(): return true
	elif cd_walk(): return true
	elif cd_jump(): return true
	elif cd_jump_move(): return true
	elif cd_falling(): return true
	elif cd_dash(): return true
	elif cd_body_slam(): return true
	elif cd_run(): return true
	return false

func cd_idle() -> bool:
	if (velocity_median() < .1 && !check_move_keys()):
		change_state(STATE.IDLE)
		return true
	return false

func cd_spin() -> bool:
	if (Input.is_action_just_pressed("cmd_attack")):
		change_state(STATE.ATTACK)
		return true
	return false

func cd_dash() -> bool:
	if Input.is_action_just_pressed("cmd_dash"):
		if velocity_median() > .5:
			change_state(STATE.DASH)
			return true
		else:
			change_state(STATE.CROUCH)
			return true
	return false

func cd_jump() -> bool:
	if velocity.y > .3 :
		change_state(STATE.JUMP)
		return true
	return false

func cd_jump_move() -> bool:
	if (velocity_median() > 1 && !is_grounded):
		change_state(STATE.JUMP_MOVE)
		return true
	return false

func cd_falling() -> bool:
	if (velocity.y < 0 && !is_grounded):
		change_state(STATE.FALLING)
		return true
	return false

func cd_walk() -> bool :
	if (check_move_keys() && is_grounded):
		change_state(STATE.WALK)
		return true
	return false
	
func cd_run() -> bool :
	if (Input.is_action_pressed("cmd_run")):
		change_state(STATE.RUN)
		return true
	return false
	
func cd_body_slam() -> bool:
	if (Input.is_action_just_pressed("cmd_dash") && !is_grounded):
		change_state(STATE.BODY_SLAM)
		return true
	return false

func st_init_idle():
	animator.play("Idle",blend_time)
	animator.playback_speed = 1

func st_update_idle():
	if cd_walk(): return
	elif cd_jump(): return
	elif cd_dash(): return
	elif cd_spin(): return

func st_init_walk():
	animator.play("Walk",blend_time)
	animator.playback_speed = 7
	
func st_update_walk():
	if cd_idle(): return
	elif cd_jump(): return
	elif cd_dash(): return
	elif cd_spin(): return
	elif cd_run(): return

func st_init_run():
	animator.play("Run",blend_time)
	animator.playback_speed = 12
	speed = initial_speed * 2

func st_update_run():
	if Input.is_action_just_released("cmd_run") or velocity_median() < .1:
		change_state(STATE.IDLE)
	elif cd_jump(): return
	elif cd_spin(): return
	elif cd_dash(): return
	
func st_exit_run():
	speed = initial_speed
	pass
	
func st_init_jump():
	if jumps > 1 and jumps_actual == 0 :
		animator.play("Jump-top",blend_time)
	else:
		animator.play("Jump",blend_time)
	animator.playback_speed = 1
	$crashbandicoot/Sounds/jump.play()

func st_update_jump():
#	if (velocity_median() > 1 and velocity.y < 1):
#		animator.play("Jump-move",.3)
#		animator.playback_speed = 4
	if cd_jump_move(): return
	elif cd_falling(): return
	elif cd_body_slam(): return
	elif cd_spin(): return

func st_init_jump_move():
	if jumps_actual == 0:
		animator.play("Jump-top",.3)
		animator.playback_speed = 2
		
	else: 
		animator.play("Jump-move",blend_time)
		animator.playback_speed = 3
		

func st_update_jump_move():
	
	if cd_idle(): return
	elif cd_spin(): return
	elif anim_finished:
		change_state(STATE.FALLING)
	pass

func st_init_crouch():
	animator.play("crouch-loop",blend_time)
	animator.playback_speed = 1.3
	can_move = false
	dir = Vector3.ZERO	
	pass
	
func st_update_crouch():
	if Input.is_action_just_released("cmd_dash"):
		change_state(STATE.IDLE)
	elif velocity.y < 0:
		change_state(STATE.FALLING)
	elif cd_idle(): return
	elif cd_jump(): return
	elif cd_falling(): return
	pass
	
func st_exit_crouch():
	print("exited crouch")
	animator.play_backwards("crouch",.2)
	can_move = true
	
#	yield(get_tree().create_timer(animator.current_animation_length,false),"timeout")

func st_init_dash():
	animator.play("Dash",blend_time)
	$crashbandicoot/Sounds/dash.play()
	animator.playback_speed = 1.5
	can_move = false
	disable_jump = true
	yield(get_tree().create_timer(dash_duration,false),"timeout")
	if cd_idle(): return
	elif cd_dash(): return
	elif cd_walk(): return
	
func st_update_dash():
	speed = initial_speed * 3
	$PPuff.custom_emit()
	if (animator.current_animation == "Dash" && animator.current_animation_position > ( animator.current_animation_length / animator.playback_speed ) * .7):
		animator.play("Dash-loop",blend_time)
		if cd_jump(): return
		if cd_spin(): return
#	if velocity_median() < 1:
#		change_state(STATE.IDLE)
	
func st_exit_dash():
	can_move = true
	speed = initial_speed
	disable_jump = false


func st_init_body_slam():
	animator.play("barricata",blend_time)
	animator.playback_speed = 2
	velocity.y = 15
	gravity = -50
	can_move = false
	dir = Vector3.ZERO
	pass
	
func st_update_body_slam():
	if (is_grounded):
#		animator.play("barricata-ground",blend_time)
		yield(get_tree().create_timer(current_animation_length() ,true),"timeout")
		change_state(STATE.IDLE)
	pass
func st_exit_body_slam():
	can_move = true
	gravity = initial_gravity
	pass
	

func st_init_falling():
	animator.play("Fall",blend_time)
	animator.playback_speed = 1.4
	pass
func st_update_falling():
	if (is_grounded):
		animator.play("FallGround",blend_time)
		if cd_any(): return
	elif cd_jump(): return
	pass
func st_exit_falling():
	$PPuff.custom_emit()
	$crashbandicoot/Sounds/step_1.play()
	pass

func st_init_attack():
	animator.play("Attack",blend_time)
	animator.playback_speed = 1
	pass
	
func st_update_attack():
	
	if anim_finished:
		if cd_falling(): return
		else: change_state(STATE.IDLE)
	pass

func st_exit_attack():
	pass

func st_init_portal():
	animator.play("Jump-portal",blend_time)
	set_process(false)
	set_physics_process(false)
	pass
func st_update_portal():
	pass


#func st_init_():
#	pass
#func st_update_():
#	pass
#func st_exit_():
#	pass


func wait_and_play_animation(animation:String):
	yield(get_tree().create_timer(animator.current_animation_length,true),"timeout")
	animator.play(animation,blend_time)

func current_animation_length() -> float:
	return animator.current_animation_length / animator.playback_speed


func check_move_keys() -> bool:
	for key in input_move_keys:
		if key: 
			return true
			break
	return false

func _ready():
	if (use_debugger and get_tree().get_nodes_in_group("debug") != null): debug = get_tree().get_nodes_in_group("debug")[0]
#	if get_tree().get_nodes_in_group("gameplay_manager")[0] != null:
#		manager_gameplay = get_tree().get_nodes_in_group("gameplay_manager")[0]
#		manager_gameplay.connect("event_game_restart",self,"_on_game_restart")
#
	register_machine()
	set_physics_process(true)
	aku = obj_aku.instance()
	aku.set_player(self)
	aku.visible = false
	get_parent().call_deferred("add_child",aku)
	power_init()

func _on_game_restart():
	ressurect()

func _process(delta):
	if (use_debugger):
		debug.set_text("velocityY",str(velocity.y))
		debug.set_text("jumpCount",str(jumps_actual))
		debug.set_text("health",str(health))
		debug.set_text("wumpa",str(iventory.wumpa))
		debug.set_text("state",str(STATE.keys()[machine.state]))
		debug.set_text("anim_finished",str(anim_finished))
		debug.set_text("grounded",str(is_grounded))
		debug.set_text("jumps",str(jumps_actual))
	input_move_keys = [Input.is_action_pressed("ui_left"),Input.is_action_pressed("ui_up"),Input.is_action_pressed("ui_down"),Input.is_action_pressed("ui_right")]
	camera = get_viewport().get_camera().get_global_transform()
	
	
	
	
#	$lookme.translation.z = dir.z
#	var cur_rot = Quat(get_transform().basis)
#	var target_rot = Quat(Vector3.UP,)
#	var smooth_rot = cur_rot.slerp(target_rot, 1)
#	set_rotation(Basis(smooth_rot).get_euler())
	machine_update()
	
	
func _physics_process(delta):
	check_grounded()
	move_calculation(delta)
#	look_system()
	check_jump()
#	check_dash()
#	check_attack()

func power_init():
	if (power_double_jump):
		power.add(power.DOUBLE_JUMP)
		jumps = power.list[power.DOUBLE_JUMP].get_jumps()
	
	for i in power.list:
		power.list[i].start()
	jumps_actual = jumps


# Functions
func kill():
	
	visible = false
	$sfx/death_woah.play()
	health = 0
	set_physics_process(false)
	manager_gameplay.trigger_game_restart()
	
	
func ressurect():
	set_physics_process(true)
	health_increase(1)
	visible = true
	aku.visible = false
	
var last_dir:Vector3 = Vector3.ZERO
var last_frame:bool = false

func check_grounded():
	if is_on_slope: 
		is_grounded = true
		velocity.y = 0
	else:
		is_grounded = is_on_floor()
	
	if is_on_floor():
		if (last_frame == false):
			jumps_actual = jumps
			last_frame = true
	else:
		last_frame = false
		
func check_jump():
	if (disable_jump): return
	if (Input.is_action_just_pressed("ui_jump") && jumps_actual >= 1):
		if (jumps > 1 && jumps_actual == jumps): #avoid spamming jump
			do_jump()
		elif (velocity.y < 1): do_jump() #velocity < 1 means falling

func check_attack():
	if (is_grounded && Input.is_action_just_pressed("cmd_attack")):
		if (!attacking):
			attacking = true
			$sfx/twist.play()
			yield(get_tree().create_timer(1,false),"timeout");
			attacking = false
		else:
			$sfx/twist_fail.play();


func do_jump():
	velocity.y = jump_force
	jumps_actual -= 1
	

var dir = Vector3()
var last_pos:Vector3
func move_calculation(delta):
	looking_system()
	
	if (!can_move):
		last_dir = dir
	
	
	if can_move:
		dir = Vector3.ZERO
		
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
	last_dir = dir
	last_pos = get_transform().origin
	
#	if (dir != Vector3.ZERO):
#		look_at = dir.x
#	rotation.y = lerp_angle(rotation.y,look_at,0.25)
	
	
#	check_input()
	if !is_on_slope:
		velocity.y += delta * gravity
	var hv = velocity
	hv.y = 0
	var new_pos = dir * speed
	var accel = de_acceleration
	if (dir.dot(hv) > 0):
		accel = acceleration
	hv = hv.linear_interpolate(new_pos, accel * delta)
	velocity.x = hv.x
	velocity.z = hv.z
	velocity = move_and_slide(velocity, Vector3(0,1,0),true)
#	velocity = move_and_slide_with_snap(velocity,Vector3(0,0,0),Vector3.UP,true)
#		velocity = move_and_collide(velocity)
	var input:Vector3 = Vector3.ZERO

var new_angle:float = 0
var new_dir:Vector3 = Vector3.ZERO

func looking_system():
	
	if (dir != Vector3.ZERO):
		new_dir = dir
	var angle:float = atan2(new_dir.x,new_dir.z)
	new_angle = lerp_angle(new_angle,angle,.25)
	var deg = rad2deg(new_angle)
	rotation_degrees.y = deg
	
func lerp_angle(from, to, weight):
	return from + short_angle_dist(from, to) * weight

func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference
	
func velocity_median() -> float:
	return (abs(velocity.x) + abs(velocity.z)) * 0.5

func is_invincible() -> bool: return aku.invincible

func health_increase(value:int=0):
	if (health + 1 <= 4):
		if value == 0:
			health += 1
		else:
			health = value
		aku._on_char_health_increased(health)

func health_decrease():
	if (health <= 0): return
	health -= 1
	if health <= 0:
		kill()
	else: 
		do_jump()
	aku._on_char_health_decreased(health)

func action_enter_portal():
	change_state(STATE.PORTAL)

func _on_Button2_pressed():
	ressurect()
	pass # Replace with function body.


func _on_Feet_area_entered(area):
	if (area.is_in_group("area_crate") && velocity.y < 1.3):
		do_jump()
		crate_collided(area)
		

func _on_Head_area_entered(area):
	if (area.is_in_group("area_crate")):
		crate_collided(area)
	
	pass # Replace with function body.

func _on_Button3_pressed():
	health_decrease()
	pass # Replace with function body.

func crate_collided(area):
	var crate = area.get_parent()
	crate._on_Jumped()


func _on_ItemBody_area_entered(item):
	if item.is_in_group("item"):
		item._on_Picked(self)
	pass # Replace with function body.

var anim_finished:bool = false
func _on_AnimationPlayer_animation_finished(anim_name):
	anim_finished = true
	print("finished")
	yield(get_tree().create_timer(.1,false),"timeout")
	anim_finished = false
	pass # Replace with function body.
