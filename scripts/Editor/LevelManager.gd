extends Spatial

func _unhandled_input(event):
	if (Utils.mouse_left_clicked(event)):
		print("clicked")
		var r = Utils.ray_mouse_to_world(event,get_viewport().get_camera(),get_world(),Utils.MASK.Selectable)
		var result = null
		if (!r.empty()):
#			if r.collider.is_in_group("gp_path_body"):
			result = r.collider.get_path()
		SelectionManager.selection_set_single(result)
