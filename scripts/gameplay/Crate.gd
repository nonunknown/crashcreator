extends RigidBody
class_name Crate

export var ID:int
export var _timeID:int = 0
export var wood_crate:bool = true
export var startGravity:bool = true
export var affectedByExplosion:bool

# ---- WUMPA
export var hasWumpa:bool
export var amtWumpa:int
export var wumpaCollection:bool
var objWumpa

# ----------------------

onready var character:Character = get_tree().get_nodes_in_group("player")[0]

func _ready():
	if !startGravity:
		sleeping = true
	if hasWumpa: wumpa_ready()
	add_to_group("gameplay_ready")


func _gameplay_ready():
	if IDTable.is_timeable(ID):
		print("timeable")
		configure_time_crate()

func wumpa_ready():
	if (wumpaCollection):
		objWumpa = preload("res://gameplay/obj_Wumpa_collection.tscn")
	else:
		objWumpa = preload("res://gameplay/obj_Wumpa.tscn")

func SpawnWumpa():
	if (!hasWumpa): return
	var cratePos = translation
	
	if (!wumpaCollection):
		for n in amtWumpa:
			var instance = objWumpa.instance()
			get_parent().add_child(instance)
			instance.translation = cratePos
	else:
		var instance = objWumpa.instance()
		get_parent().add_child(instance)
		instance.translation = cratePos

func Destroy(free:bool=true):
	$CollisionShape.disabled = true
	$sfx.play()
	$Particle.emitting = true
	$model.visible = false
	if free:
		yield(get_tree().create_timer($sfx.stream.get_length(),false),"timeout")
		queue_free()

func configure_time_crate():
	var game_manager = get_tree().get_nodes_in_group("gameplay_manager")[0]
	game_manager.connect("time_trial_activated",self,"_on_time_trial_activated")
	print("time crate config successfully")

func _on_Attacked():
	print("please implement onAttackedFunction")
	
func _on_Jumped():
	print("please implement onJumpedFunction")

func _on_Exploded():
	print("not affected by explosion")

func _on_time_trial_activated():
	print("time crate 2")
	var time_crate = IDTable.crates[10].instance()
	var pos = translation
	Destroy(false)
	get_parent().add_child(time_crate)
	time_crate.translation = pos
	queue_free()
	pass

