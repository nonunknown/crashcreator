extends AnimationTree

onready var playback:AnimationNodeStateMachinePlayback = get("parameters/playback")
onready var character:Character = get_parent()
onready var animPlayer:AnimationPlayer = get_node(self.get_animation_player())#get_parent().get_node("Crash/AnimationPlayer")

onready var debug = get_parent().get_parent().get_node("DebugText")
func _ready():
	debug.add_text(2)
	debug.add_text(3)
func _process(delta):
	set("parameters/OnGround/move/blend_amount",velocity_median())
	set("parameters/OnGround/walk_speed/scale",velocity_median() * 1.4)
	set("parameters/conditions/c_jump",is_moving_y())
	set("parameters/OnAir/conditions/c_start_fall",(character.velocity.y <= -1))
	set("parameters/OnAir/conditions/c_is_grounded",character.is_grounded)
	set("parameters/OnAir/conditions/c_is_moving",(velocity_median() > 1))
	debug.set_text(2,"startFall: "+str( get("parameters/OnAir/conditions/c_start_fall")))
	debug.set_text(3,"Grounded: "+str( character.is_grounded))
	
func velocity_median() -> float:
	return (abs(character.velocity.x) + abs(character.velocity.z)) * 0.5

func is_moving_y()->bool:
	if (character.velocity.y > 1):
		return true 
	else: 
		return false 
