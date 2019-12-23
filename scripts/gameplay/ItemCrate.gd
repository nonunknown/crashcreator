extends Spatial

export var startGravity:bool = true

export var affectedByExplosion:bool

# ---- WUMPA
export var hasWumpa:bool
export var amtWumpa:int
export var wumpaCollection:bool
var objWumpa

# ----------------------

func _ready():
	if startGravity:
		get_child(0).sleeping = false
	wumpa_ready()
	
	
func wumpa_ready():
	if (hasWumpa):
		if (wumpaCollection):
			objWumpa = preload("res://gameplay/obj_Wumpa_collection.tscn")
		else:
			objWumpa = preload("res://gameplay/obj_Wumpa.tscn")

func SpawnWumpa():
	var cratePos = get_translation()
	
	if (!wumpaCollection):
		for n in amtWumpa:
			var instance = objWumpa.instance()
			get_parent().add_child(instance)
			instance.translation = cratePos
	else:
		var instance = objWumpa.instance()
		get_parent().add_child(instance)
		instance.translation = cratePos

func Destroy():
	
	#var part = $Particles.duplicate()
	#get_parent().add_child(part)
	#$Particles.queue_free()
	#part.emitting = true
	#todo free part
	print("particle System to implement and sound")
	queue_free()

			
func _on_Attacked():
	print("please implement onAttackedFunction")
	
func _on_Jumped():
	print("please implement onJumpedFunction")

func _on_Exploded():
	print("not affected by explosion")
