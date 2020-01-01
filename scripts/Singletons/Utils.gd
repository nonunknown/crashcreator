extends Node

class FSM_Manager:
	var current:FSM = null
	var states:Dictionary = {}
	var state_list:Dictionary
	var go_next_state:bool = false
	var next_state:FSM = null
	var target:Node = null
	
	func _init(state_list:Dictionary,target:Node):
		self.state_list = state_list
		self.target = target
		
		pass
	func change_state(to):
		current._on_exit()
		current = to
		current._on_enter()
		go_next_state = false
		next_state = null
		
	func set_next_state(state:FSM):
		next_state = state
		go_next_state = true

	func add_state(state:FSM):
		states[state.id] = state
	
	func start():
		current = states[0]
		pass
		
	func update(delta):
		current._update(delta)
		if (go_next_state):
			change_state(next_state)
		
class FSM:
	var manager:FSM_Manager = null
	var id:int = -1

	func _init(id:int,manager:FSM_Manager):
		self.manager = manager
		self.id = id
		
		print("SELF: "+str(self))
		self.manager.add_state(self)


	func _on_enter():
		pass

	func _on_exit():
		pass

	func _update(delta):
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


func wait_for_seconds(time:float):
	yield(get_tree().create_timer(time,false),"timeout")

func destroy_after(time:float):
	wait_for_seconds(time)
	queue_free()
