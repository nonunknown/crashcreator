extends RigidBody

export var startGravity:bool = true
export var hasWumpa:bool
export var amtWumpa:int

onready var objWumpa = preload("res://gameplay/obj_Wumpa.tscn")

func _ready():
	if startGravity:
		sleeping = false
		print("set gravity")
	pass
	
func _on_Attacked():
	print("please implement onAttackedFunction")
	
func _on_Jumped():
	print("please implement onJumpedFunction")


func SpawnWumpa():
	var cratePos = get_translation()
	for wumpa in amtWumpa:
		var instance = objWumpa.instance()
		get_parent().get_parent().add_child(instance)
		instance.translation = cratePos

func Destroy():
	
	var part = $Particles.duplicate()
	get_parent().add_child(part)
	$Particles.queue_free()
	part.emitting = true
	#todo free part
	print("particle System to implement and sound")
	queue_free()
