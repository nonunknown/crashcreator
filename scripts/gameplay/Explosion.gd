extends Spatial
class_name Explosion

var effect = preload("res://resources/gameplay/explosion.tscn")
	
func _init(parent):
	var explosion_fx = effect.instance()
	parent.add_child(explosion_fx)
	print("Explosion")
