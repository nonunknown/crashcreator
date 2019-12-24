extends Spatial

func destroy():
	queue_free()


func _on_Area_explosion_body_entered(body):
	print("body: "+str(body.name))
	if (body.get_parent().is_in_group("gp_crate")):
		print("cratebody")
		body.get_parent()._on_Exploded()
