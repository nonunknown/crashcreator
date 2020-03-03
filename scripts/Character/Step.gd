extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var sounds:Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var last_n = 0
func play_step():
	var n:int = int(rand_range(0,len(sounds)))
	while(n == last_n):
		n = int( rand_range(0,len(sounds)))
	
	get_node(sounds[n]).play()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
