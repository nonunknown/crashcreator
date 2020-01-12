extends Spatial

signal time_trial_activated
signal time_trial_freeze

func event_time_activate():
	emit_signal("time_trial_activated")
	print("activated")
	
func event_time_free(time):
	emit_signal("time_trial_freeze",time)

func _gameplay_ready():
	print("hello world!")

func _enter_tree():
	name = "Gameplay"

func _ready():
	if (GameManager.is_mode_play()):
		print("configuring gameplay ready method")
		var nodes = get_tree().get_nodes_in_group("gameplay_ready")
		print("node is group gready: "+str(nodes))
		for child in nodes:
			if child.has_method("_gameplay_ready"):
				print("node with _gameplay_ready method: "+child.name)
				child._gameplay_ready()
