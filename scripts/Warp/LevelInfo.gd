extends Control
class_name LevelInfo

func config(name:String):
	$l_title.text = name
	
func show():
	$AnimationPlayer.play("show")
	visible = true
	
func hide():
	visible = false
