extends Node

enum MODE {EDIT,PLAY,LOAD}

var GAME_MODE:int = MODE.EDIT
var path_to_project:String = ""


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
	
func change_scene_forced(path:String,to_gamemode:int):
	set_gamemode(to_gamemode)
	get_tree().change_scene(path)
	pass

func load_project(dir:String):
	print("loading")
	var manager_editor = get_tree().get_root().get_node("/root/Main")
	manager_editor.emit_signal("change_mode",Utils.EDITOR_STATE.NEW)
	set_gamemode(MODE.LOAD)
	path_to_project = dir
	manager_editor.emit_signal("change_mode",Utils.EDITOR_STATE.LOAD)
	
	pass
