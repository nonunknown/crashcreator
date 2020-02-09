extends Camera
class_name LookCamera

var character:Character
export var follow_x:bool = false
export var offset:Vector3

func _ready():
	character = Utils.get_player()

func _process(delta):
	look_at(character.translation + offset,Vector3.UP)
	if follow_x:
		var x = translation.x
		x = lerp(translation.x,character.translation.x,0.01)
		translation.x = x
