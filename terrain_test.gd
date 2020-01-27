extends Spatial

#var points:PoolVector3Array

export var material:SpatialMaterial
export var y_multiplier:float
export var uv1_scale:int
var mesh:Mesh
var subdivision:int = 0
var thread:Thread
var points_right:PoolVector3Array = []
var points_left:PoolVector3Array = []

func _exit_tree():
	thread.wait_to_finish()
	
func _ready():
	thread = Thread.new()
	thread.start(self,"exec")
	pass

func _process(delta):
	pass
#		get_borders()
#		check_points()
#		make_quad()

func exec(userdata):
	print("started")
	yield(get_tree().create_timer(5,false),"timeout")
	get_borders()
	check_points(points_right)
	make_quad(points_right,true)
	check_points(points_left)
	make_quad(points_left,false)
#	yield(get_tree().create_timer(1,false),"timeout")

export var draw_vertexes = false
func draw_vertex(pos:Vector3,color:Color=Color.green):
	if draw_vertexes == false : return
	var spr = $sprite
	spr.visible = true
	spr.modulate = color
#	spr.get_material_override().set("albedo_color",color)
	var inst = spr.duplicate()
	inst.translation = pos
	add_child(inst)

var _count = 0
var _pass:bool = true
func check_points(points:PoolVector3Array):
	print("starting check")
	_count += 1
	var i = 0
	while i < points.size():
		
		print("is i: "+str(i)+" less than: "+str(points.size()))
		var pos = points[i]
		if i == 0:
			draw_vertex(pos,Color.black)
		if (i+1 < points.size()):
			var next_point = points[i+1]
			print("pos: "+str(pos)+"/ next: "+str(next_point)+" = dist: "+str(pos.distance_to(next_point)))
			if pos.distance_to(next_point) > 7:
				var new_pos = (pos+next_point)/2
				points.insert(i+1,new_pos)
#				var new_point = point_zero.duplicate()
				
#				get_borders()
				draw_vertex(new_pos,Color.blue)
				i = 0
#				yield(get_tree().create_timer(.1,false),"timeout")
			elif pos.distance_to(next_point) < 4:
				draw_vertex(pos,Color.aqua)
				draw_vertex(next_point,Color.aqua)
				var new_pos = (pos+next_point)/2
				points.remove(i)
				points.remove(i)
				points.insert(i,new_pos)
				draw_vertex(new_pos,Color.pink)
				
				
				

		i += 1
#		draw_vertex(pos,color)
		
	print("pass: "+str(_pass))

func get_borders():
	print("getting borders")
	var borders = get_tree().get_nodes_in_group("borders")
	for border in borders:
		var pos = border.get_global_transform().origin
		draw_vertex(pos,Color.red)
		if border.is_in_group("right"):
			points_right.push_back(pos)
#			draw_vertex(pos,Color.green)
		elif border.is_in_group("left"):
			points_left.push_back(pos)
#			draw_vertex(pos,Color.green)K
#			draw_vertex(border.translation,Color.red)
#		elif border.is_in_group("left"):
##			left_borders.push_back(border.translation)
#	points = []
#	for point in right_borders:
#		points.push_back(point)



func make_quad(points:PoolVector3Array,right:bool):
	print(points)
#	create_vertexes()
	subdivision = points.size()-2
	var plane = PlaneMesh.new()
	plane.size = Vector2(5,5)
	plane.subdivide_depth = subdivision
	plane.subdivide_width = subdivision
	var surface:SurfaceTool = SurfaceTool.new()
	surface.create_from(plane,0)
	var arr_plane = surface.commit()

	var data = MeshDataTool.new()
	data.create_from_surface(arr_plane,0)
	var noise = $Sprite3D.texture.get("noise")
	var column = points.size()
	if right:
		points.invert()
	var dir = Vector3.LEFT
	if !right: dir = Vector3.RIGHT

	for i in range(data.get_vertex_count()):
	
		var vertex = data.get_vertex(i)
		print(str(i%column))
		if i % column == 0:
			print("i from 0: "+str( i))
#			draw_vertex(points[i],Color.beige)
			
			vertex = points[i/column]
		else:
			print("i from 1: "+str( i))
			var v = data.get_vertex(i-1)  + ( dir * 10 ) 
			vertex = v
			vertex.y = noise.get_noise_3d(vertex.x,vertex.y,vertex.z) * y_multiplier
			
#			draw_vertex(v)

		draw_vertex(vertex,Color.blue)
		data.set_vertex(i,vertex)
	
	for i in range(arr_plane.get_surface_count()):
		arr_plane.surface_remove(i)
	
	data.commit_to_surface(arr_plane)
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	surface.create_from(arr_plane,0)
#	surface.add_normal(Vector3.DOWN)
	surface.generate_normals()

	generate_mesh(surface.commit())

func generate_mesh(mesh:Mesh):
	var instance = MeshInstance.new()
	instance.mesh = mesh
	instance.set_surface_material(0,material)
	instance.get_surface_material(0).set("uv1_scale",Vector3(uv1_scale,uv1_scale,uv1_scale))
	add_child(instance)
