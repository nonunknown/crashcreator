
extends Control
class_name ButtonMesh

export var scn:Mesh
func set_mesh(mesh:Mesh):
	get_node("ViewportContainer/Viewport/MeshInstance").mesh = mesh

func _ready():
	
	pass
