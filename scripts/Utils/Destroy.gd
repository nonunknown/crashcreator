extends Spatial

func _ready():
	$fx1.emitting = true
	$fx2.emitting = true
	yield(get_tree().create_timer(.2,false),"timeout")
	$Area_explosion/CollisionShape.disabled = true
	yield(get_tree().create_timer(1,false),"timeout")
	queue_free()

func set_radius(value:float):
	$Area_explosion/CollisionShape.shape.radius = value

func play_sound():
	$sfx.play()

func _on_Area_explosion_body_entered(body):
	print("explosion detected: "+body.name)
	if (body.collision_layer == Utils.MASK.Player):
			body.death_type = Character.DEATH.BURNED
			body.health_decrease()
			
	if (body.is_in_group("crate") ):
		body._on_Exploded()


func _on_area_entered(area):
	print(area.collision_layer)
	pass # Replace with function body.
