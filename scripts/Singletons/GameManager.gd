extends Node

enum MODE {EDIT,PLAY}

var GAME_MODE:int = MODE.EDIT

func set_gamemode(mode:int):
		print("last mode: "+str(MODE.keys()[GAME_MODE]))
		GAME_MODE = mode
		print("new mode: "+str(MODE.keys()[GAME_MODE]))
		
func is_mode_play()->bool:
	if GAME_MODE == MODE.PLAY: return true
	return false

func change_scene(actual_scene_name:String,new_scene:PackedScene):
	var root = get_tree().get_root()
	print(new_scene)
	print("changing scene")
#	root.call_deferred("add_child",new_scene.instance())
	root.call_deferred("remove_child",root.get_node(actual_scene_name))
	
