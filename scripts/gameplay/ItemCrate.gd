extends RigidBody

export var wood_crate:bool = true
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
		sleeping = false
	wumpa_ready()
	
	
func wumpa_ready():
	if (hasWumpa):
		if (wumpaCollection):
			objWumpa = preload("res://gameplay/obj_Wumpa_collection.tscn")
		else:
			objWumpa = preload("res://gameplay/obj_Wumpa.tscn")

func SpawnWumpa():
	if (!hasWumpa): return
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
	$CollisionShape.disabled = true
	
	if (wood_crate):
		var audio:AudioStreamPlayer3D = get_node("sfx")
		var p:Particles = get_node("Particle")
		audio.play()
		p.emitting = true
		get_node("model").visible = false
		yield(get_tree().create_timer(audio.stream.get_length(),false),"timeout")
		
	visible = false	
	queue_free()

			
func _on_Attacked():
	print("please implement onAttackedFunction")
	
func _on_Jumped():
	print("please implement onJumpedFunction")

func _on_Exploded():
	print("not affected by explosion")
