extends Control
class_name Transition

func start_transition(id:int,speed:float=1):
	$AnimationPlayer.playback_speed = speed
	match id:
		0: to_fade_in()
		1: to_fade_out()
		2: to_black()
		3: to_clean()

func to_fade_in():
	print("fadein")
	$AnimationPlayer.play("fade-in")
	pass
	
func to_fade_out():
	$AnimationPlayer.play("fade-out")
	pass

func to_black():
	$AnimationPlayer.play("black")
	
func to_clean():
	$AnimationPlayer.play("alpha")

func _on_AnimationPlayer_animation_finished(anim_name):
	
	pass # Replace with function body.
