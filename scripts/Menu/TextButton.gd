extends Button
class_name TextButton

func _on_TextButton_mouse_entered():
	$AnimationPlayer.play("hover")
	$Audio.play()
	pass # Replace with function body.


func _on_TextButton_mouse_exited():
	$AnimationPlayer.stop(true)
	pass # Replace with function body.


func _on_TextButton_pressed():
	print("define action 1")
	pass # Replace with function body.
