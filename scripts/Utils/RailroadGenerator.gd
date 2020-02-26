tool
extends Path

export var generate:bool = false
export var rail_straigt:Mesh

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if generate:
		generate = false
		var t = Thread.new()
		t.start(self,"generate_path")
#		generate_path()
	pass # Replace with function body.

func generate_path(data):
	clear()
	print(curve.get_baked_points().size())
	var baked_points = curve.get_baked_points()
	baked_points.invert()
#	print(baked_points)
	var vectors:Array = []
	var last:Spatial = null
	for i in range(baked_points.size()):
		var spatial = Spatial.new()
		add_child(spatial)
		
		spatial.translation = baked_points[i]
#		if i>0: spatial.look_at(last)
		last = spatial
		var node = MeshInstance.new()
		node.mesh = rail_straigt
		spatial.add_child(node)

func clear():
	for child in get_children():
		child.call_deferred("free")

