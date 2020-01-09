extends Button

enum {START,END}

onready var entity_manager = get_node("/root/Main/Level/Entity")
export var _ID:int = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed",self,"_on_pressed")
	
	pass # Replace with function body.


func _on_pressed():
	entity_manager.set_entity(_ID)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
