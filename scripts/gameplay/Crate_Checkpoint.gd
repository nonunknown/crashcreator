extends Crate
class_name CrateCheckpoint

export var checkpoint_id:int = 0

func _init():
	._init()
	add_to_group("checkpoint")
	add_to_group("restart")
	
func save_crates():
	print("saving crates")
	for crate in get_tree().get_nodes_in_group("crate"):
		if (crate.destroyed == false):
			crate.add_to_group(str(checkpoint_id))
	pass
	print("crates in checkpoint: "+str(get_tree().get_nodes_in_group(str(checkpoint_id))))

func _on_game_restart():
	print("restart checkpoint")
	for crate in get_tree().get_nodes_in_group(str(checkpoint_id)):
		print("crate in checkpoin: "+str(checkpoint_id)+"/ "+str(crate.name))
		print("destroyed: "+str( crate.destroyed) )
		
		if (crate.destroyed == true):
			print("reviving crate: "+crate.name)
			crate.revive()
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
