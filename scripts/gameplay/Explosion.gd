extends Spatial
class_name Explosion

var effect = preload("res://resources/gameplay/explosion.tscn")
	
func _init(parent,spawn_pos):
	var explosion_fx = effect.instance()
	explosion_fx.translation = spawn_pos
	parent.add_child(explosion_fx)
	explosion_fx.play_sound()
