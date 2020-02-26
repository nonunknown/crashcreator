class_name CharacterMachine

var character
var manager = Utils.MachineManager.new()

var blend_time
var animator
var movement

func _init(_target):
	character = _target
	blend_time = character.blend_time
	manager.register_state_array(self,[IDLE,
	WALK,RUN,JUMP,CROUCH,DASH,JUMP_MOVE,BODY_SLAM,FALLING,ATTACK,PORTAL],[
		"idle","walk","run","jump","crouch","dash","jump_move","body_slam","falling","attack","portal"
	])
	manager.change_state(IDLE)


enum {IDLE,WALK,RUN,JUMP,CROUCH,DASH,JUMP_MOVE,BODY_SLAM,FALLING,ATTACK,PORTAL}

func do_update():
	manager.machine_update()
	

func stop():
	animator.stop(false)

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
	if (character.virtual_hspeed < .2 && character.is_grounded):
		manager.change_state(IDLE)
		return true
	return false

func cd_spin() -> bool:
	if (Input.is_action_just_pressed("cmd_attack")):
		manager.change_state(ATTACK)
		return true
	return false

func cd_dash() -> bool:
	if Input.is_action_just_pressed("cmd_dash") && character.is_grounded:
		manager.change_state(DASH)
		return true
#		else:
#			manager.change_state(CROUCH)
#			return true
	return false

func cd_jump() -> bool:
	if ( character.linear_velocity.y > .3 && !character.is_grounded ):
		manager.change_state(JUMP)
		return true
	return false

func cd_jump_move() -> bool:
	if (character.virtual_hspeed > .3 && !character.is_grounded && character.linear_velocity.y > .3):
		manager.change_state(JUMP_MOVE)
		return true
	return false

func cd_falling() -> bool:
	if (character.linear_velocity.y < .3 && !character.is_grounded):
		manager.change_state(FALLING)
		return true
	return false

func cd_walk() -> bool :
	if (character.virtual_hspeed > .1 && character.is_grounded):
		manager.change_state(WALK)
		return true
	return false
	
func cd_run() -> bool :
	if (Input.is_action_pressed("cmd_run")):
		manager.change_state(RUN)
		return true
	return false
	
func cd_body_slam() -> bool:
	if (Input.is_action_just_pressed("cmd_dash") && !character.is_grounded):
		manager.change_state(BODY_SLAM)
		return true
	return false

func st_init_idle():
	character.animator.play("idle",blend_time)
	character.animator.playback_speed = 1

func st_update_idle():
	if cd_walk(): return
	elif cd_jump(): return
	elif cd_spin(): return
#	elif cd_dash(): return
	pass

func st_exit_idle():
	return

func st_init_walk():
	character.animator.play("walk-loop",blend_time)
	character.animator.playback_speed =  3
	
func st_update_walk():
	if cd_idle(): return
	elif cd_jump(): return
	elif cd_falling(): return
	elif cd_dash(): return
	elif cd_spin(): return
	elif cd_run(): return

func st_exit_walk():
	return

func st_init_run():
	character.animator.play("run-loop",blend_time)
	character.animator.playback_speed = 5
	character.max_speed = character.initial_maxspeed * 1.5

func st_update_run():
	if Input.is_action_just_released("cmd_run"):
		if cd_walk(): return
		else: manager.change_state(IDLE)
	elif cd_jump(): return
	elif cd_spin(): return
	elif cd_dash(): return
	elif cd_falling(): return
	
func st_exit_run():
	character.max_speed = character.initial_maxspeed
	pass
	
func st_init_jump():
#	if character.jumps > 1 and character.jumps_actual == 0 :
#		animator.play("Jump-top",blend_time)
	
	character.get_node("crashbandicoot/Sounds/jump").play()
	if cd_jump_move(): return
	character.animator.play("jump",blend_time)
	character.animator.playback_speed = 1

func st_update_jump():
	if cd_falling(): return
	elif cd_idle():return
	elif cd_walk(): return
	if cd_jump_move(): return
#	elif cd_body_slam(): return
#	elif cd_spin(): return

func st_exit_jump():
	return

func st_init_jump_move():
#	if character.jumps_actual == 0:
#		animator.play("Jump-top",.3)
#		animator.playback_speed = 2
#
#	else: 
	character.animator.play("jump-move",blend_time)
	character.animator.playback_speed = 2.5
		

func st_update_jump_move():
	if cd_idle(): return
	elif cd_walk(): return
#	elif cd_spin(): return
#	if character.anim_finished:
#		if cd_falling(): return
	pass

func st_exit_jump_move():
	return

func st_init_crouch():
	animator.play("crouch-loop",blend_time)
	animator.playback_speed = 1.3
	character.can_move = false
	character.dir = Vector3.ZERO	
	pass
	
func st_update_crouch():
	if Input.is_action_just_released("cmd_dash"):
		manager.change_state(IDLE)
	elif character.linear_velocity.y < 0:
		manager.change_state(FALLING)
	elif cd_idle(): return
	elif cd_jump(): return
	elif cd_falling(): return
	pass
	
func st_exit_crouch():
	print("exited crouch")
	animator.play_backwards("crouch",.2)
	character.can_move = true
	
#	yield(get_tree().create_timer(animator.current_animation_length,false),"timeout")
var exit_dash:bool = false
func st_init_dash():
	character.enable_controls(false)
	character.linear_velocity += character.get_global_transform().basis.z * 15
	character.animator.play("Dash",blend_time)
	character.get_node("crashbandicoot/Sounds/dash").play()
	character.animator.playback_speed = 1.5
	yield(character.get_tree().create_timer(character.dash_duration,false),"timeout")
	exit_dash = true
	
func st_update_dash():
#	character.max_speed = character.max_speed * 2
	character.get_node("PPuff").custom_emit()
	if (character.animator.current_animation == "Dash" && 
		character.animator.current_animation_position > ( character.animator.current_animation_length / character.animator.playback_speed ) * .7):
		character.animator.play("Dash-loop",blend_time)
		if (character.jump_attempt): #TODO: Can jump on dash
			character.do_jump()
	if exit_dash:
		if cd_walk(): return
		elif cd_idle(): return
		elif cd_jump_move(): return
	
func st_exit_dash():
	exit_dash = false
	character.enable_controls(true)
#	character.max_speed = character.initial_maxspeed
	pass
#	movement.can_move = true
#	character.speed = character.initial_speed
#	character.disable_jump = false

func st_init_body_slam():
	animator.play("barricata",blend_time)
	animator.playback_speed = 2
	character.linear_velocity.y = 15
	character.gravity = -50
	character.can_move = false
	character.dir = Vector3.ZERO
	pass
	
func st_update_body_slam():
	if (character.is_grounded):
#		animator.play("barricata-ground",blend_time)
		yield(character.get_tree().create_timer(character.current_animation_length() ,true),"timeout")
		manager.change_state(IDLE)
	pass

func st_exit_body_slam():
	character.can_move = true
	character.gravity = character.initial_gravity
	pass
	

func st_init_falling():
	character.animator.play("fall",blend_time)
	character.animator.playback_speed = 1
	pass
	
func st_update_falling():
	if cd_idle(): return
	elif cd_walk(): return
#	if (character.is_grounded):
#		animator.play("FallGround",blend_time)
#		if cd_any(): return
#	elif cd_jump(): return
	pass
func st_exit_falling():
	character.get_node("PPuff").custom_emit()
	character.get_node("crashbandicoot/Sounds/step_1").play()
	pass

var timer = .4
var sound_twist:AudioStreamPlayer3D
func st_init_attack():
	sound_twist = character.get_node("sfx/twist")
#	character.animator.play("Attack",blend_time)
#	character.animator.playback_speed = 1
	sound_twist.play()
	timer = sound_twist.stream.get_length()
	character.armature.visible = false
	character.twist_crash.visible = true
	
	pass

func st_update_attack():
	character.twist_crash.rotate_y(-.7)
	timer -= Utils.global_delta
	if timer <= 0:
		if cd_falling(): return
		elif cd_idle(): return
		elif cd_walk(): return

func st_exit_attack():
	character.armature.visible = true
	character.twist_crash.visible = false
	return

func st_init_portal():
	animator.play("Jump-portal",blend_time)
	character.set_process(false)
	character.set_physics_process(false)
	pass
func st_update_portal():
	pass

func st_exit_portal():
	return

#func st_init_():
#	pass
#func st_update_():
#	pass
#func st_exit_():
#	pass
