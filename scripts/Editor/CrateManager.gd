extends Spatial

export var crate_model:PackedScene 
onready var manager_editor:EditorManager = get_node("/root/Main")
# Called when the node enters the scene tree for the first time.
var crate
var first_load = true
var _tool = 0
var ID = 1

func _ready():
	manager_editor.connect("change_mode",self,"_on_changed_mode")
#	_start()
	
func _process(_delta):
	if (!_tool == 1): return
	_update()
	
func _on_changed_mode(_tool):
	self._tool = _tool
	if _tool == 1:
		_start()
	
func _start():
	if (first_load):
		crate = crate_model.instance()
		get_node("/root/Main").add_child(crate)
		first_load = false
		
	else: 
		print("visible")
		crate.visible = true
		
	pass
	
func _exit():
	if (crate != null):
		print("not visible")
		crate.visible = false

var r = {}
var last_pos:Vector3 = Vector3.ZERO
func _update():
	var pos = last_pos
	if (!r.empty()):
		pos = r.position
	crate.translation = pos
	
	last_pos = pos
	pass
	
func _unhandled_input(event):
	if !_tool == 1: return
	if (event is InputEventMouseMotion):
		r = Utils.ray_mouse_to_world(event,get_viewport().get_camera(),get_world(),Utils.MASK.Selectable)
	if (Utils.mouse_left_clicked(event)):
		spawn_crate()
	
func spawn_crate():
	var s = crate.duplicate(8)
	s.translation = crate.translation
	add_child(s)
	
func set_crate(texture:Texture):
	var mat:SpatialMaterial = SpatialMaterial.new()
	mat.albedo_texture = texture
	var inst:MeshInstance = crate.get_child(0)
	inst.set_material_override(mat)
#	inst.set_surface_material(0,mat)
#	inst.set_surface_material(1,mat)
