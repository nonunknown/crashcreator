extends Crate
class_name CrateNitro
func _ready():
	if (startGravity):
		nitro_hop()
	pass


func nitro_hop():
	randomize()	
	$AnimationPlayer.play("hop")
	$AnimationPlayer.advance(rand_range(0,5))

func _on_Exploded():
	Destroy()
#	$Particle.emitting = true
	$Area/CollisionShape.disabled = true
	$sfx_explosion.play()
	Explosion.new(get_parent(),self.global_transform.origin)
#	$model.visible = false
#	$CollisionShape.disabled = true
#	yield(get_tree().create_timer(3,false),"timeout")
#	queue_free()

func revive():
	.revive()
	$Area/CollisionShape.disabled = false
	
	pass



func _on_Attacked():
	_on_Exploded()

func _on_Area_body_entered(body):
	_on_Exploded()
