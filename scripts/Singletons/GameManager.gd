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
#
#func change_scene(actual_scene_name:String,new_scene:PackedScene):
#	var root = get_tree().get_root()
#	print(new_scene)
#	print("changing scene")
##	root.call_deferred("add_child",new_scene.instance())
#	root.call_deferred("remove_child",root.get_node(actual_scene_name))
	
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
	
var _loader = null
var _error = false
var _repeat = true
signal done
var loaded_scene = null
func change_scene_async(path:String,params:Dictionary={}):
	_loader = null
	_error = false
	_repeat = true
	print(path)
	_loader = ResourceLoader.load_interactive(path)
	while(_repeat):
		yield(_update_load(),"completed")
	if _error :
		print("error")
		return null
	print("loading")

	var to_scene = _loader.get_resource()
	loaded_scene = to_scene.instance()
	yield(get_tree().create_timer(2,false),"timeout")
	emit_signal("done")
	
#	if not params.empty():
#		current_scene.start_params(params)
		



func _update_load() -> Node:
	if _loader == null:
		print("stopped loading scene")
		_error = true
		
	
	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + 100 :
		var err = _loader.poll()
		
		if err == ERR_FILE_EOF: # finished loading
			_error = false
			_repeat = false
			print("loaded")
			break
		elif err == OK:
			var progress = float(_loader.get_stage()) / _loader.get_stage_count()
			print("loading: "+str(progress * 100)+"/100")
			_repeat = true
			break
		else:
			_loader = null
			print("error: "+str( err) )
			_error = true
			_repeat = false
	return yield(get_tree(),"idle_frame")
