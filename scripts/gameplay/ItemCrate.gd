extends Spatial

export var hasGravity:bool = false
export var hasWumpa:bool
export var amtWumpa:int

onready var objWumpa = preload("res://gameplay/obj_Wumpa.tscn")

func _ready():
	pass
	
func _on_Attacked():
	print("please implement onAttackedFunction")
	
func _on_Jumped():
	print("please implement onJumpedFunction")


func SpawnWumpa():
	var cratePos = get_translation()
	for wumpa in amtWumpa:
		var instance = objWumpa.instance()
		get_parent().add_child(instance)
		instance.translation = cratePos

func Destroy():
	$Particles.emitting = true
	print("particle System to implement and sound")
	#queue_free()
