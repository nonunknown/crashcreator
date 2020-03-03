tool
extends Path

export var generate:bool = false
export var rail_straigt:Mesh
onready var path_follow:PathFollow = $PathFollow
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if not Engine.editor_hint:
		path_follow.offset += delta
	
	if generate:
		generate = false
		generate_path()
#		generate_path()
	pass # Replace with function body.

func generate_path(data=null):
	clear()
	print(curve.get_baked_points().size())
	var baked_points = curve.get_baked_points()
	baked_points.invert()
#	print(baked_points)
	var vectors:Array = []
	var last:Spatial = null
	for i in range(baked_points.size()):
#		var spatial = Spatial.new()
#		add_child(spatial)
#		spatial.set_owner(get_tree().get_edited_scene_root())
#		spatial.translation = baked_points[i]
#		if i>0: spatial.look_at(last)
#		if last!= null:
#			spatial.look_at(last)
#		last = spatial.get_global_transform().origin
		
		var node = MeshInstance.new()
		node.mesh = rail_straigt
		add_child(node)

func clear():
	for child in get_children():
		child.queue_free()

