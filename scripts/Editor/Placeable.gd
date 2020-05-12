extends Spatial #needs to extends spatial due to get_world function
class_name Placeable

var ray_dict = {}

func _unhandled_input(event):
	if (event is InputEventMouseMotion):
		ray_dict = Utils.ray_mouse_to_world(event,get_viewport().get_camera(),get_world(),Utils.MASK.Selectable)
	if (Utils.mouse_left_clicked()):
		pass
