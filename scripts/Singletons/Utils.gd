extends Spatial

enum EDITOR_STATE {NEW,SAVE,LOAD,PATH,CRATE,ITEM,ENTITY,ENEMY,TIME,LIGHT,TEST,BUILD,SETTINGS}

class MachineManager:
	var machine:Dictionary = {
		state=null,
		funcs={
			init={},
			update={},
			exit={}
			}
		}

	func register_state(target,state_const:int,name:String,has_init:bool=true,has_exit:bool=false):
		if (has_init):
			machine.funcs.init[state_const] = funcref(target,"st_init_"+name)
		machine.funcs.update[state_const] = funcref(target,"st_update_"+name)
		if (has_exit):
			machine.funcs.exit[state_const] = funcref(target,"st_exit_"+name)
	
	func register_state_array(target,states_const:Array,names:Array):
		for i in states_const.size():
			register_state(target,states_const[i],names[i],true,true)
	
	func machine_update():
		machine.funcs.update[machine.state].call_func()
	
	func change_state(to):
		if machine.funcs.exit.has(machine.state):
			machine.funcs.exit[machine.state].call_func()
		machine.state = to
		if machine.funcs.init.has(machine.state):
			machine.funcs.init[to].call_func() #call the init function of next states
		
	
	func get_current_state() -> int: return machine.state

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

func list_directory(path:String) -> Array:
	var dir = Directory.new()
	var file_list = []
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if not dir.current_is_dir():
				print("Found file: " + file_name)
				file_list.append(str(path)+str(file_name))
			file_name = dir.get_next()
		return file_list
	else:
		print("An error occurred when trying to access the path.")
		return []

func wait_for_seconds(time:float):
	yield(get_tree().create_timer(time,false),"timeout")

func destroy_after(time:float,target:Node):
	wait_for_seconds(time)
	target.queue_free()

var ray_dict = {}
signal mouse_left_clicked
func _unhandled_input(event):
	if (event is InputEventMouseMotion):
		ray_dict = ray_mouse_to_world(event,get_viewport().get_camera(),get_world(),MASK.Selectable)
	if (Utils.mouse_left_clicked(event)):
		emit_signal("mouse_left_clicked")
