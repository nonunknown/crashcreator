extends Camera


func _process(delta):
	var player = Utils.get_player().translation
	var value = sign(player.x)
	var boss = get_tree().get_nodes_in_group("boss")[0].get_global_transform().origin
	var radians = rad2deg(self.translation.angle_to(player))
	get_parent().get_parent().rotation_degrees.y = radians * value
	get_tree().get_nodes_in_group("debug")[0].set_text("radians",radians * value)
#	look_at(player,Vector3.UP)
#	look_at(player,Vector3.UP)
#	translate(Vector3.RIGHT * delta)
