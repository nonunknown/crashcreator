extends Spatial

signal time_trial_activated
signal time_trial_freeze
signal event_game_restart

export var simulate_ready = false

func _ready():
	if (simulate_ready): 
		GameManager.set_gamemode(GameManager.MODE.PLAY)
		_gameplay_ready()
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("event_game_restart")
		print("pressed accept")
		
func subscribe_all_children_to_restart(target:Node):
	print("nodes in restart: "+str(get_tree().get_nodes_in_group("restart")))
	for child in get_tree().get_nodes_in_group("restart"):
		print("i am subscribed: "+child.name)
		self.connect("event_game_restart",child,"_on_game_restart")
	pass

func event_time_activate():
	emit_signal("time_trial_activated")
	print("activated")
	
func event_time_freeze(time):
	emit_signal("time_trial_freeze",time)

func _gameplay_ready():
	print("gameplay's ready")
	if (GameManager.is_mode_play()):
#		print("configuring gameplay ready method")
		var nodes = get_tree().get_nodes_in_group("gameplay_ready")
#		print("node is group gready: "+str(nodes))
		for child in nodes:
			if (child == self): 
#				print("its a me! gameplay")
				continue
			if child.has_method("_gameplay_ready"):
#				print("node with _gameplay_ready method: "+child.name)
				child._gameplay_ready()
		subscribe_all_children_to_restart(self)
		
		
