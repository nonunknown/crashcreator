tool
extends Spatial
class_name Chunk

export var chunk_size:int
export var chunk_extents:Vector3
export var update:bool

var area:Area = null
var chunks:Spatial = null
func _ready():
	area = $Area

func _process(_delta):
	if update:
		update = false
		adjust_chunk_size()
		adjust_chunk_extents()

func adjust_chunk_size():
	$AreaBase/CollisionShape.shape.extents = Vector3(chunk_size,chunk_size,chunk_size)

func adjust_chunk_extents():
	var child = $AreaBase.duplicate(8)
	if chunks == null:
		chunks = Spatial.new()
		add_child(chunks)
		chunks.set_owner(get_tree().get_edited_scene_root())
	else:
		for child in chunks.get_children():
			child.queue_free()
	chunks.add_child(child)
	child.set_owner(get_tree().get_edited_scene_root())
	pass
