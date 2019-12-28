extends Crate

var health:int = 5

func decrease_health():
	health -= 1
	character.iventory.add_wumpa(2)
	$Anim.play("bounce")
	print("bounce")
	$sfx_bounce.play()
	$sfx_bounce.pitch_scale += 0.02
	if (health <= 0):
		_on_Attacked()

func _on_Attacked():
	$model.visible = false
	$CollisionShape.disabled = true
	$Particle.emitting = true
	$sfx_crate.play()
	yield(get_tree().create_timer($sfx_crate.stream.get_length(),false),"timeout")
	queue_free()
	
func _on_Jumped():
	print("jumped")
	decrease_health()
	

