class_name GameplayEvent

var target:Node
var manager_gameplay:ManagerGameplay
func _init(_target):
	target = _target
	if target.get_tree().get_nodes_in_group("gameplay_manager") != null:
		manager_gameplay = target.get_tree().get_nodes_in_group("gameplay_manager")[0]
		manager_gameplay.connect("event_game_restart",target,"_on_game_restart")
	
