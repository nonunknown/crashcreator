extends AnimationTree

onready var playback:AnimationNodeStateMachinePlayback = get("parameters/playback")
onready var character:Character = get_parent()
onready var animPlayer:AnimationPlayer = get_node(self.get_animation_player())#get_parent().get_node("Crash/AnimationPlayer")

onready var debug = get_parent().get_parent().get_node("DebugText")

func _process(delta):
	set("parameters/OnGround/move/blend_amount",velocity_median())
	set("parameters/OnGround/walk_speed/scale",velocity_median() * 1.4)
	set("parameters/conditions/c_jump",is_moving_y())
	set("parameters/OnAir/conditions/c_start_fall",(character.velocity.y <= -1))
	set("parameters/OnAir/conditions/c_is_grounded",character.is_grounded)
	set("parameters/conditions/c_is_grounded",character.is_grounded)
	set("parameters/OnAir/conditions/c_is_moving",(velocity_median() > 1))
	set("parameters/conditions/c_is_moving",(velocity_median() > 1))
	debug.set_text("startfall",str( get("parameters/OnAir/conditions/c_start_fall")))
	debug.set_text("grounded",str( character.is_grounded))
	
	set("parameters/conditions/c_moving_dash",Input.is_action_just_pressed("cmd_dash") && velocity_median() > 1)
	set("parameters/conditions/c_idle_dash",Input.is_action_just_pressed("cmd_dash") && velocity_median() < 1)
	set("parameters/conditions/c_wake_up",Input.is_action_just_released("cmd_dash"))
	#Todo: c_dash_end
func velocity_median() -> float:
	return (abs(character.velocity.x) + abs(character.velocity.z)) * 0.5

func is_moving_y()->bool:
	if (character.velocity.y > 1):
		return true 
	else: 
		return false 
