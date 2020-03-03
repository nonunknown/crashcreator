extends Spatial


export var mat_time_zero:SpatialMaterial
export var mat_time_one:SpatialMaterial
export var mat_time_two:SpatialMaterial
export var mat_time_three:SpatialMaterial

var editor_state:EditorState
var time_crate = 0
var cursors = [
	load("res://cursor/time_zero.png"),
	load("res://cursor/time_one.png"),
	load("res://cursor/time_two.png"),
	load("res://cursor/time_three.png"),
	load("res://cursor/normal.png")
	
	
]

onready var materials = [mat_time_zero,mat_time_one,mat_time_two,mat_time_three]

func _ready():
	editor_state = EditorState.new(Utils.EDITOR_STATE.TIME,self)
	

func _enter():
	print("hello world!!!")
	Utils.set_mouse_mask(Utils.MASK.Selectable_crate)
	turn_all_crates_time()
	set_time_crate(0)
	pass
	
func _update():
	if Utils.mouse_left_clicked():
		if Utils.ray_dict.empty(): return
		if not Utils.ray_dict.collider.get_parent().is_in_group("timeable"): return
		var clicked_crate:Node = Utils.ray_dict.collider.get_parent()
		modify_crate(clicked_crate)
			
	pass
	check_change_time()
	
func _exit():
	Utils.set_mouse_mask(Utils.MASK.Selectable)
	Input.set_custom_mouse_cursor(cursors[4])
	turn_all_crates_normal()
	pass
	
	
func check_change_time():
	if (Input.is_action_just_pressed("zero")):
		set_time_crate(0)
	elif(Input.is_action_just_pressed("one")):
		set_time_crate(1)
	elif(Input.is_action_just_pressed("two")):
		set_time_crate(2)
	elif(Input.is_action_just_pressed("three")):
		set_time_crate(3)
	
func set_time_crate(n:int):
	if n >=0 and n<= 3:
		time_crate = n
		Input.set_custom_mouse_cursor(cursors[n])
	else: printerr("invalid time crate: allowed between 0 and 3")


func turn_all_crates_time():
	for crate in get_tree().get_nodes_in_group("timeable"):
		crate.get_child(0).set_material_override(materials[crate._time_ID])
		pass
	pass
	
func turn_all_crates_normal():

	for crate in get_tree().get_nodes_in_group("timeable"):
		crate.get_child(0).set_material_override(crate.editor_material)
	pass
	
func modify_crate(crate:Node):
	var mesh:MeshInstance = crate.get_child(0)
	mesh.set_material_override(materials[time_crate])
	crate._time_ID = time_crate
	pass
