extends KinematicCharacter
class_name Character

# signal increased_health(amt)
# signal decreased_health(amt)
signal died

export var use_debugger:bool = false
export var blend_time:float = .1
export var dash_duration:float = 1.5
export var power_double_jump:bool = false
export var onjump_raycast_to:float = -1
export var material_black:SpatialMaterial

var dashing = false
var attacking:bool = false
var health = 1
var obj_aku = preload("res://gameplay/obj_akuaku.tscn")
var death_burned = preload("res://deaths/obj_death_burned.tscn")
var aku:Node
var debug = null
var cam_target:Node
var event_gameplay:GameplayEvent

onready var power:Power = Power.new()
onready var iventory:Iventory = Iventory.new()
onready var input_move_keys:Array
onready var animator:AnimationPlayer = get_node("crashbandicoot/AnimationPlayer")
onready var twist_crash:Node = $crashbandicoot/twistcrash
onready var armature = $crashbandicoot/Armature
onready var machine:CharacterMachine = CharacterMachine.new(self)
onready var pos_future = $PosFuture
onready var mesh:MeshInstance = $crashbandicoot/Armature/Skeleton/Crash
#PowerStuff
var jumps:int = 1
var jumps_actual:int = 0
var jump_enabled:bool = true


func wait_and_play_animation(animation:String):	
	# last_frame = false
	yield(get_tree().create_timer(animator.current_animation_length,true),"timeout")
	animator.play(animation,blend_time)

func current_animation_length() -> float:
	return animator.current_animation_length / animator.playback_speed


func check_move_keys() -> bool:
	for key in input_move_keys:
		if key: 
			return true
	return false

func _ready():
	._ready()
	event_gameplay = GameplayEvent.new(self)
	if (use_debugger and get_tree().get_nodes_in_group("debug") != null): debug = get_tree().get_nodes_in_group("debug")[0]
	
	
	set_physics_process(true)
	aku = obj_aku.instance()
	aku.set_player(self)
	aku.visible = false
	get_parent().call_deferred("add_child",aku)
	power_init()

func _on_game_restart():
	if (death_node != null):
		death_node.call_deferred("queue_free")
	ressurect()
	translation = initial_pos

func _process(delta):
	._process(delta)
	if (use_debugger):
		debug.set_text("Hvelocity",str(virtual_hspeed))
		debug.set_text("Vvelocity",str(linear_velocity.y))
		debug.set_text("health",str(health))
		debug.set_text("wumpa",str(iventory.wumpa))
		debug.set_text("exitdash",machine.exit_dash)
#		debug.set_text("state",str(machine..keys()[machine.state]))
		debug.set_text("jumpattempt",str(jump_attempt))
		debug.set_text("grounded",str(is_grounded))
		debug.set_text("jumps",str(jumps_actual))
	input_move_keys = [Input.is_action_pressed("ui_left"),Input.is_action_pressed("ui_up"),Input.is_action_pressed("ui_down"),Input.is_action_pressed("ui_right")]
	is_grounded = is_rays_colliding()
	if is_grounded && Input.is_action_just_pressed("ui_jump") && jump_enabled:
		do_jump()
	machine.do_update()
	if Input.is_action_just_pressed("ui_accept"):
		print(translation)
	pos_future.translation = lerp(Vector3.ZERO,Vector3.BACK * max_speed, virtual_hspeed * .1)

func is_rays_colliding() -> bool:
	for ray in $Rays.get_children():
		if ray.is_colliding():
			return true
	return false

func do_jump():
	.do_jump()
	if virtual_hspeed > 0:
		$Rays/RayCast.cast_to.y = onjump_raycast_to

func power_init():
	if (power_double_jump):
		power.add(power.DOUBLE_JUMP)
		jumps = power.list[power.DOUBLE_JUMP].get_jumps()
	
	for i in power.list:
		power.list[i].start()
	jumps_actual = jumps


var death_node = null
func play_burned():
#	mesh.set_material_override(material_black)
	visible = false
	death_node = death_burned.instance()
	get_parent().add_child(death_node)
	death_node.translation = translation
	
# Functions
enum DEATH {UNKNOWN,BURNED}
var death_type = 0
func kill():
	emit_signal("died")
#	visible = false
	machine.manager.change_state(machine.IDLE)
	animator.playback_speed = 0
	var old_rot:Vector3 = rotation_degrees
	look_at(get_viewport().get_camera().get_global_transform().origin,Vector3.UP)
	rotation_degrees = ( rotation_degrees * Vector3(0,1,0) ) + ( old_rot * Vector3(1,0,1) )
	$sfx/death_woah.play()
	health = 0
	set_physics_process(false)
	if death_type == DEATH.BURNED:
		play_burned()
	event_gameplay.manager_gameplay.trigger_game_restart()
	

func ressurect():
	visible = true
	mesh.set_material_override(null)
	set_physics_process(true)
	health_increase(1)
	visible = true
#	movement.last_dir = Vector3.ZERO
#	movement.last_frame = false
	


func check_attack():
	pass
#	if (movement.is_grounded && Input.is_action_just_pressed("cmd_attack")):
#		if (!attacking):
#			attacking = true
#			$sfx/twist.play()
#			yield(get_tree().create_timer(1,false),"timeout");
#			attacking = false
#		else:
#			$sfx/twist_fail.play();


	
func velocity_median() -> float:
#	return movement.velocity_median
	return 0.1

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
	pass
#	machine.change_state(machine.PORTAL)

func enable_controls(enabled:bool=false):
	is_machine_controlled = !enabled
	jump_enabled = enabled

func _on_Button2_pressed():
	ressurect()
	pass # Replace with function body.


func _on_Feet_area_entered(area):
	if (area.is_in_group("area_crate") && linear_velocity.y < 1.3):
		if Input.is_action_pressed("ui_jump"):
			extra_jump_force = 1.3
		do_jump()
		
		crate_collided(area)
#	print("implement on_feet_entered")
		

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


func _on_ItemBody_area_entered(area):
		area.get_parent()._on_Picked(self)

var anim_finished:bool = false
func _on_AnimationPlayer_animation_finished(anim_name):
	anim_finished = true
	
	print("finished")
