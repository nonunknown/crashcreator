tool
extends MultiMeshInstance

export var render:bool = false
export var rows:int = 1
export var columns:int = 1
export var check_dist:float = .2

# Called when the node enters the scene tree for the first time.
func generate():
	multimesh.instance_count = rows * columns
	for x in range(rows):
		for z in range(columns):
			var value = ( z % 2 ) * check_dist
			if value == 0: value = 1
			print(value)
			multimesh.set_instance_transform(z * multimesh.instance_count/columns +x,Transform(Basis(Vector3(0,rand_range(0,360),0)),Vector3(x * value,0,z)))
	pass # Replace with function body.

func _process(delta):
	if render:
		render =false
		generate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
