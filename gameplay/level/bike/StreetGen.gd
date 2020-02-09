extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var first:bool = true
var is_curve:bool = false
var curve_id:int = -1
func work(target:Node=null):
	if (target == null): target = self
	yield(get_tree().create_timer(.7,false),"timeout")
	var inst = self.duplicate()
	inst.first = false
	
#	if !is_curve:
#		inst.is_curve = true
#		inst.rotation_degrees.y = inst.curve_id * 15
#		inst.curve_id = 1
#	else: 
#		inst.is_curve = false
#		inst.rotation_degrees.y = 0

	get_parent().add_child(inst)
	inst.translation = target.get_node("End").get_global_transform().origin
	inst.work(self)
	yield(get_tree().create_timer(20,false),"timeout")
	call_deferred("queue_free")
# Called when the node enters the scene tree for the first time.
func _ready():
	if (first):
		work(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
