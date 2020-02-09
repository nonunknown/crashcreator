extends RigidBody
class_name Dynamite

var time = 1
var exploded = false
func _process(delta):
	time -= delta
	if time<=0 && !exploded:
		exploded = true
		Explosion.new(get_parent(),translation)
		call_deferred("queue_free")
		pass
