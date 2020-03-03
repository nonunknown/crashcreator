tool
extends Control
class_name MeshButton

export var show_mesh:Mesh
export var mesh_rotation:Vector3
export var camera_zoom:float
export var camera_offset:Vector3
var mesh_instance:MeshInstance
var camera:Camera
export var change_mesh:bool = false
# Called when the node enters the scene tree for the first time.
func _enter_tree():
	mesh_instance = $ViewportContainer/Viewport/MeshInstance
	camera = $ViewportContainer/Viewport/Camera
	pass # Replace with function body.

func _process(delta):
	if change_mesh:
		mesh_instance.rotation_degrees = mesh_rotation
		mesh_instance.mesh = show_mesh
		camera.look_at(mesh_instance.translation + camera_offset,Vector3.UP)
		camera.fov = camera_zoom
		
		change_mesh= false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	pass # Replace with function body.
