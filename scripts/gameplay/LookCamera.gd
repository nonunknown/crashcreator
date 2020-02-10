extends Camera
class_name LookCamera

var character:Character
export var follow_x:bool = false
export var offset:Vector3

func _ready():
	character = Utils.get_player()

func _process(delta):
#	look_at(character.translation + offset,Vector3.UP)
	if follow_x:
		var x = translation.x
		x = lerp(translation.x,character.translation.x,0.01)
		translation.x = x
	if can_reparent:
		look_at(character.translation + offset,Vector3.UP)
		translation = lerp(translation,base.get_global_transform().origin,0.01)

var can_reparent = false
onready var base:Spatial = get_node("../Path/PathFollow/base")
func change_parent():
	can_reparent = true
	
#	var new_parent = get_node("../Path/PathFollow")
#	get_parent().remove_child(self)
#	new_parent.call_deferred("add_child",self)
