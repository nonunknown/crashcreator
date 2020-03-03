tool
extends Spatial
class_name Builder

export var group:String
export var generate:bool =false

export var path_node:NodePath
var path:Path

var points_array:PoolVector3Array = []
func _process(delta):
	if generate:
		generate = false
		config()
		get_points()
		generate_points()

func config():
	if path == null:
		path = get_node(path_node)
	get_node("../Viewer").i = 0

func gen_text():
	var viewer = get_parent().get_node("Viewer")
	viewer.create_text_pool_at(points_array)
	
func get_points():
	points_array = []
	var borders = get_tree().get_nodes_in_group(group)
	var last_inverted = true
	for border in borders:
		print(border.get_parent().get_parent().name)
		var arr = border.get_children()
		var temp:PoolVector3Array = []
		for point in arr:
			var pos = point.get_global_transform().origin
			temp.push_back(pos)
		temp.invert()
		for pos in temp:
			points_array.push_back(pos)
			get_node("../Viewer").create_text_at(pos)
			
		
#		if !last_inverted:
#			points_array.invert()
#			last_inverted = true
#		else: last_inverted = false

func generate_points():
	var curve = path.curve
	curve.clear_points()
	for point in points_array:
		curve.add_point(point)
