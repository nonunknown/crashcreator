extends Node

class FSM_Manager:
	var current:FSM = null
	var states = {}

	func change_state(to):
		current._on_exit()
		current = to
		current._on_enter()

	var node = null

	func set_node(n):
		node = n
		
class FSM:
	var manager = null

	func set_manager(m):
		manager = m

	func _on_enter():
		pass

	func _on_exit():
		pass
	

const ray_length = 1000
enum MASK {Selectable=64}
func ray(world,from,to,collision_mask) -> RayCast:
	var space_state = world.direct_space_state
	return space_state.intersect_ray(from, to,[],collision_mask)
	
	
func ray_mouse_to_world(event,camera,world,collision_mask=1) -> RayCast:
	var from = camera.project_ray_origin(event.position)
	var to = from + camera.project_ray_normal(event.position) * ray_length
	return ray(world,from,to,collision_mask)
	# result.collider.get_parent().material_override = SpatialMaterial.new()
	 
func mouse_left_clicked(event) -> bool:
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		return true 
	else: return false

func file_exists(path:String,fileName:String,delete:bool=false):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if not dir.current_is_dir():
				print("Found directory: " + file_name)
				if (file_name == fileName): 
					if (delete):
						dir.remove(path+"/"+fileName)
					return true
			file_name = dir.get_next()
		return false
	else:
		print("An error occurred when trying to access the path.")
		return false

func wait(time:float,caller:Node,method:String):
	var timer = Timer.new()
	get_tree().get_child(0).add_child(timer)
	timer.start(time)
	timer.connect("timeout",caller,method)
