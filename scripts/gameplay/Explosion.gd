extends Spatial
class_name Explosion

var effect = preload("res://resources/gameplay/explosion.tscn")
	
func _init(parent,spawn_pos,radius:float=3):
	
	var explosion_fx = effect.instance()
	if radius > 0:
		explosion_fx.set_radius(radius)
	explosion_fx.translation = spawn_pos
	parent.add_child(explosion_fx)
	explosion_fx.play_sound()
