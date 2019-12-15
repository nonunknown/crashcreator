extends Node

var selected_single = null
var selected_multi = []

func selection_set_single(path):
	if (selected_single == null or selected_single == path):
		selected_single = path
	else:
		selected_single.st_manager.change_state(selected_single.st_manager.states[selected_single.ST_UNSELECTED])
		selected_single = path
		selected_single.st_manager.change_state(selected_single.st_manager.states[selected_single.ST_SELECTED])



func selection_get_single():
	return selected_single
