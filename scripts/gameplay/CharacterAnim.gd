extends AnimationTree

onready var playback:AnimationNodeStateMachinePlayback = get("parameters/playback")
onready var character:Character = get_parent()
onready var animPlayer:AnimationPlayer = get_node(self.get_animation_player())#get_parent().get_node("Crash/AnimationPlayer")

onready var debug = get_parent().get_parent().get_node("DebugText")

func _process(_delta):
	set("parameters/OnAir/conditions/c_is_grounded",character.is_grounded)
	set("parameters/conditions/c_is_grounded",character.is_grounded)
	set("parameters/OnGround/move/blend_amount",character.velocity_median())
	set("parameters/OnGround/walk_speed/scale",character.velocity_median() * 1.4)
	
	set("parameters/OnAir/conditions/c_is_moving",(character.velocity_median() > 1))
	set("parameters/conditions/c_is_moving",(character.velocity_median() > 1))
	
	set("parameters/conditions/c_jump",is_moving_y())
	set("parameters/OnAir/conditions/c_start_fall",(character.velocity.y <= -1))
	
	set("parameters/conditions/c_dash",character.dashing == true)
	set("parameters/conditions/c_dash_end",character.dashing == false)
	set("parameters/conditions/c_crouch",Input.is_action_just_pressed("cmd_dash") && character.velocity_median() < 1)
	set("parameters/conditions/c_wake_up",Input.is_action_just_released("cmd_dash"))
	
	set("parameters/conditions/c_attack",character.attacking)
	
	
	debug.set_text("grounded",str( character.is_grounded))
	

	#Todo: c_dash_end

func is_moving_y()->bool:
	if (character.velocity.y > 1):
		return true 
	else: 
		return false
