class_name GameplayEvent

var target:Node
var manager_gameplay:ManagerGameplay
func _init(_target):
	target = _target
	print(target.get_tree().get_nodes_in_group("gameplay_manager"))
	if target.get_tree().get_nodes_in_group("gameplay_manager").size() != 0:
		manager_gameplay = target.get_tree().get_nodes_in_group("gameplay_manager")[0]
		for i in range(manager_gameplay.methods.size()):
			if target.has_method(manager_gameplay.methods[i]):
				manager_gameplay.connect(manager_gameplay.events[i],target,manager_gameplay.methods[i])
