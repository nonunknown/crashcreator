

extends TextureButton

export var ID:int
export var texture:Texture
onready var gui_tools_crate = get_node("/root/Main/GUI/GUI_tools_crate")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	texture_normal = texture
	connect("pressed",self,"set_crate")
	
	pass # Replace with function body.

func set_crate():
	var n = get_tree().get_nodes_in_group("crate_manager")[0]
	n.set_crate(texture)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
