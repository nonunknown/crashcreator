extends Node
class_name LevelBuilder


func start():
	if !level_is_valid(): 
		printerr("LEVEL VALIDATION ERROR")
		return
	print("SUCCESS - VALIDATED LEVEL")
	
	if !create_game_level():
		printerr("LEVEL CREATION ERROR")
		return
	print("SUCCESS - LEVEL CREATED")
	
	if (!save_game_level()):
		printerr("LEVEL FILE SAVE ERROR")
		return
	print("SUCCESS - LEVEL FILE CREATED")
	
	load_generated_file()
	
	
func level_is_valid() -> bool:
	if !entity_is_valid(): return false
	if !path_is_valid(): return false
	if !crate_is_valid(): return false
	return true
	
func entity_is_valid() -> bool:
	if get_tree().get_nodes_in_group("entity_manager")[0].get_child_count() < 2:
		printerr("At Builder: "+"please place start and finish entities")
		return false
	return true

func path_is_valid() -> bool:
	if get_tree().get_nodes_in_group("path_manager")[0].get_child_count() == 0:
		printerr("At Builder: the level needs at least one path placed")
		return false
	return true

func crate_is_valid() -> bool:
	return true

var game_level = null
func create_game_level() -> bool:
	var to_load = load("res://scenes/scn_Gameplay.tscn")#get_node("/root/Main/Level").duplicate(8)
	game_level = to_load.instance()
	var editor_level = get_node("/root/Main/Level")
	editor_level.visible = false
	add_child(game_level)
	build_entity()
	build_path()
	build_crate()
	return true

func save_game_level() -> bool:
	var packed_scene:PackedScene = PackedScene.new()
	remove_child(game_level)
	get_tree().root.add_child(game_level)
	packed_scene.pack(game_level)
	var err = ResourceSaver.save("user://temp.tscn",packed_scene)
	if (err == OK):
		print("SAVED FILE SUCCESSFULLY")
		
		return true
	printerr("at builder's save game level: SAVE ERROR: "+str(err))
	return false

func load_generated_file():
	GameManager.set_gamemode(GameManager.MODE.PLAY)
	GameManager.change_scene("Main",game_level)
	

func build_path():
	var paths = get_tree().get_nodes_in_group("path_manager")[0].get_children()
	var path_manager = game_level.get_node("Path")
	for path in paths:
		var copy = path.duplicate(8)
		path_manager.add_child(copy)
		copy.set_owner(game_level)
	path_manager.set_owner(game_level)
	
func build_crate():
	var crates = get_tree().get_nodes_in_group("crate_manager")[0].get_children()
	var crate_manager = game_level.get_node("Crate")
	for crate in crates:
		var game_crate:PackedScene = IDTable.crates[crate._ID]
		var inst = game_crate.instance()
		inst.translation = crate.translation
		crate_manager.add_child(inst)
		inst.set_owner(game_level)
		pass
	pass

func build_entity():
	var entities = get_tree().get_nodes_in_group("entity_manager")[0].get_children()
	var entity_manager = game_level.get_node("Entities")
	for entity in entities:
		var game_entity:PackedScene = IDTable.entities[entity._ID]
		var instance = game_entity.instance()
		instance.translation = entity.translation
		entity_manager.add_child(instance)
		instance.set_owner(game_level)
