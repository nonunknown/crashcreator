extends Crate
class_name CrateWoodJump

func _on_Attacked():
	SpawnWumpa()
	Destroy()
#	$model.visible = false
#	$CollisionShape.disabled = true
#	$Particle.emitting = true
#	$sfx_crate.play()
#	yield(get_tree().create_timer($sfx_crate.stream.get_length(),false),"timeout")
#	queue_free()
	
func _on_Jumped():
	$Anim.play("bounce")
	$sfx_bounce.play()
	

