extends Item
class_name ItemClock

onready var time_trial:TimeTrial = TimeTrial.new() 


func _player_picked(_player):
	var clock_hud:Node = get_tree().get_nodes_in_group("hud")[0]
	clock_hud.visible = true
	add_child(time_trial)
	var gameplay_manager = get_tree().get_nodes_in_group("gameplay_manager")[0]
	gameplay_manager.event_time_activate()

func _on_Area_body_entered(body):
	_on_Picked(body)
	
	pass # Replace with function body.
