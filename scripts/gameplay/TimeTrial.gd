extends Node
class_name TimeTrial

var time = 0
var gui_clock
func _enter_tree():
	gui_clock = get_tree().get_nodes_in_group("hud")[1]
	
	
func _process(delta):
	time += delta
	gui_clock.set_time(time)
	pass
