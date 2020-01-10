extends Spatial
class_name CrateManager

export var crate_model:PackedScene 

var editor_state:EditorState
var crate
var first_load = true

func _ready():
	editor_state = EditorState.new(Utils.EDITOR_STATE.CRATE,self)
	Utils.connect("mouse_left_clicked",self,"_on_mouse_left_clicked")


func _on_changed_mode(_tool):
	pass
	
func _enter():
	print("crate start")
	if (first_load):
		crate = crate_model.instance()
		get_node("/root/Main").add_child(crate)
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

	
func spawn_crate():
	var s:Node = crate.duplicate(8)
	s.set_script(EditorCrate)
	s._ID = selected_crate_id
	print(s.get_data())
	s.translation = crate.translation + ( Vector3.UP * 0.05)
	add_child(s)
	s.set_owner(self)
	
#received signal from: bt_crate
var selected_crate_id:int = -1
func _on_changed_crate(id:int,texture:Texture):
	selected_crate_id = id
	var mat:SpatialMaterial = SpatialMaterial.new()
	mat.albedo_texture = texture
	var inst:MeshInstance = crate.get_child(0)
	inst.set_material_override(mat)
#	inst.set_surface_material(0,mat)
#	inst.set_surface_material(1,mat)


func _on_mouse_left_clicked():
	if editor_state.get_current_state() == Utils.EDITOR_STATE.CRATE && selected_crate_id != -1:
		spawn_crate()
