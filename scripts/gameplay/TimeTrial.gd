extends Node
class_name TimeTrial

var time = 0
var gui_clock
func _enter_tree():
	gui_clock = get_tree().get_nodes_in_group("gui_clock")[0]
	var gameplay_manager = get_tree().get_nodes_in_group("gameplay_manager")[0]
	gameplay_manager.connect("time_trial_freeze",self,"_on_freeze")
	
var wait_time = 0
func _process(delta):
	if (wait_time <= 0):
		time += delta
	else:
		wait_time -= delta
	gui_clock.set_time(time)
	pass

func _on_freeze(_time):
	print("freezed time trial")
	wait_time = _time
