extends Crate
class_name CrateCheckpoint

var checkpoint_id:int = -2

func _init():
	._init()
	add_to_group("restart")
	
func _ready():
	._ready()
	checkpoint_id = get_checkpoint_id()
	print("check ID: "+ str( checkpoint_id))
	
func get_checkpoint_id() -> int:
	var id:int = -1
	var crates = get_tree().get_nodes_in_group("checkpoint")
	for i in crates.size():
		if crates[i] == self:
			id = i
	return id

onready var gameplay_manager:ManagerGameplay = get_tree().get_nodes_in_group("gameplay_manager")[0]
func set_last_checkpoint() -> void:
	var crates = get_tree().get_nodes_in_group("checkpoint")
	for crate in crates:
		if crate != self:
			if gameplay_manager.is_connected("event_game_restart",crate,"_on_game_restart"):
				gameplay_manager.disconnect("event_game_restart",crate,"_on_game_restart")


func save_crates():
	print("saving crates")
	for crate in get_tree().get_nodes_in_group("crate"):
		if (crate.destroyed == false):
			crate.add_to_group(str(checkpoint_id))
	pass
	print("crates in checkpoint: "+str(get_tree().get_nodes_in_group(str(checkpoint_id))))


	
	pass
func _on_game_restart():
	print("restart checkpoint")
	for crate in get_tree().get_nodes_in_group(str(checkpoint_id)):
		print("crate in checkpoin: "+str(checkpoint_id)+"/ "+str(crate.name))
		print("destroyed: "+str( crate.destroyed) )
		
		if (crate.destroyed == true):
			print("reviving crate: "+crate.name)
			crate.revive()
	get_tree().get_nodes_in_group("player")[0].translation = translation+Vector3.UP
	pass

func _on_Attacked():
	$model/AnimationPlayer.play("open");
	$Area/CollisionShape.disabled = true
	Destroy(false)
	save_crates()
	pass
	
func _on_Jumped():
	_on_Attacked()
	pass
	
func _on_Exploded():
	_on_Attacked()
	pass
