extends Spatial
class_name CrateManager

export var crate_model:PackedScene 

var editor_state:EditorState
var crate
var first_load = true

func _ready():
	editor_state = EditorState.new(Utils.EDITOR_STATE.CRATE,self)

func reset():
	var children = get_children()
	for child in children:
		child.queue_free()
	selected_crate_id = -1

func _on_changed_mode(_tool):
	pass
	
func _enter():
	load_virtual_crate()

export var main_path:NodePath
func load_virtual_crate():
	if (first_load):
		crate = crate_model.instance()
		get_node(main_path).add_child(crate)
		first_load = false
	else: 
		crate.visible = true
	pass

var last_pos:Vector3 = Vector3.ZERO
#var tile_size = .5
func _update():
	var pos = last_pos
	if (!Utils.ray_dict.empty()):
		#var v = Utils.ray_dict.position / tile_size
		pos = Utils.ray_dict.position
	crate.translation = pos
	
	last_pos = pos
	
	if Input.is_action_just_pressed("mouse_left_button") and selected_crate_id != -1:
		spawn_crate()
	
	pass

func _exit():
	print("crate exit")
	
	if (crate != null):
		crate.visible = false
#func _unhandled_input(event):
#	if !_tool == 1: return
#	if (event is InputEventMouseMotion):
#		r = Utils.ray_mouse_to_world(event,get_viewport().get_camera(),get_world(),Utils.MASK.Selectable)
#	if (Utils.mouse_left_clicked(event)):
#		spawn_crate()

	
func spawn_crate(id:int = -2,time_id:int = -2,pos:Vector3 = Vector3.ZERO):
	var _id = -1
	if id == -2: _id = selected_crate_id
	else: _id = id
	
	var _time_id = 0
	if time_id != -2: _time_id = time_id
	
	load_virtual_crate()
	if id != -2: _on_changed_crate(_id)
	
	var s:Node = crate.duplicate(8)
	s.set_script(EditorCrate)
	s.configure(_id)
	if is_timeable(s._ID):
		s.add_to_group("timeable")
		s._time_ID = _time_id
	if pos == Vector3.ZERO:
		s.translation = crate.translation + ( Vector3.UP * 0.05)
	else:
		s.translation = pos
	add_child(s)
	s.set_owner(self)


#check if is changed by timetrial
func is_timeable(id):
	for n in IDTable.timeable_crates:
		if n == id:
			return true
			break
	return false
#received signal from: bt_crate
var selected_crate_id:int = -1
func _on_changed_crate(id:int):
	selected_crate_id = id
	var mat = IDTable.get_mat_from_tex_id(id)
	
	var inst:MeshInstance = crate.get_child(0)
	inst.set_material_override(mat)
#	inst.set_surface_material(0,mat)
#	inst.set_surface_material(1,mat)



