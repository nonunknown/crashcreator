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

func ray(world,from,to) -> RayCast:
	var space_state = world.direct_space_state
	return space_state.intersect_ray(from, to,[],0x00000007)
	
	
func ray_mouse_to_world(event,camera,world) -> RayCast:
	var from = camera.project_ray_origin(event.position)
	var to = from + camera.project_ray_normal(event.position) * ray_length
	return ray(world,from,to)
	# result.collider.get_parent().material_override = SpatialMaterial.new()
	 
func mouse_left_clicked(event) -> bool:
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		return true 
	else: return false
		  
