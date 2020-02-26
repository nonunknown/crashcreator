extends Spatial
class_name ManagerGameplay

signal time_trial_activated
signal time_trial_freeze
signal event_game_restart
signal event_boss_wait

var methods = ["_on_game_restart","_on_boss_wait"]
var events = ["event_game_restart","event_boss_wait"]

export var simulate_ready = false

func _ready():
	if (simulate_ready): 
		GameManager.set_gamemode(GameManager.MODE.PLAY)
		_gameplay_ready()
	pass

func trigger_boss_wait(started:bool=true):
	emit_signal("event_boss_wait",started)

func trigger_game_restart(wait:float=2):
	
	yield(get_tree().create_timer(wait,false),"timeout")
	Utils.make_transition(Utils.EFFECT.FADE_IN,2)
	yield(get_tree().create_timer(2,false),"timeout")
	emit_signal("event_game_restart")
	_on_game_restart()

func subscribe_all_children_to_restart():
	print("nodes in restart: "+str(get_tree().get_nodes_in_group("restart")))
	for child in get_tree().get_nodes_in_group("restart"):
		print("i am subscribed: "+child.name)
		var err = self.connect("event_game_restart",child,"_on_game_restart")
		if err != OK:
			print("error at connecting: "+str( err))
	pass

func event_time_activate():
	emit_signal("time_trial_activated")
	print("activated")
	
func event_time_freeze(time):
	emit_signal("time_trial_freeze",time)

func _gameplay_ready():
	print("gameplay's ready")
	if (GameManager.is_mode_play()):
		var nodes = get_tree().get_nodes_in_group("gameplay_ready")
		for child in nodes:
			if (child == self): continue
			if child.has_method("_gameplay_ready"):
				child._gameplay_ready()
		subscribe_all_children_to_restart()
		connect("event_game_restart",self,"_on_game_restart")
		
func _on_game_restart():
	yield(get_tree().create_timer(1),"timeout")
	Utils.make_transition(Utils.EFFECT.FADE_OUT)

