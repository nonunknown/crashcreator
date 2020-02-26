extends Node

var SCENES = []

var NODES = {}

#DO NOT CALL MANUALLY#
func add_scene(node):
	SCENES.append(node)
	if !NODES.has(node):
		NODES[node] = {}

#DO NOT CALL MANUALLY#
func remove_scene(node):
	SCENES.erase(node)
	if NODES.has(node):
		NODES.erase(node)

#DO NOT CALL MANUALLY#
func new_registry(root,key,node):
	NODES[root][key] = node;

#DO NOT CALL MANUALLY#
func erase_registry(root,key):
	NODES[root].erase(key)

#DO NOT CALL MANUALLY#
func belongs_to_scene(node):
	if node == null:
		push_warning("NodeFinder: E0 This node is null")
		return
	if node.get_tree() == null:
		push_warning("NodeFinder: E1 This node doesnt belong to a tree")
		return
	if node.get_tree().current_scene == null:
		push_warning("NodeFinder: E2 Can't access root of scene, node: "+node.name +node)
		return
	if !SCENES.has(node.get_tree().current_scene):
		add_scene(node.get_tree().current_scene)
	#
	return node.get_tree().current_scene

func get(key: String, suppress: bool = false):
	var scene = []
	var found_total = 0
	for scn in SCENES:
		if !NODES.has(scn):
			push_warning("NodeFinder: E4 The root node of this object is not registered")
			return
		for key_in_scene in NODES[scn].keys():
			if key_in_scene == key:
				scene.append(scn)
				found_total += 1
	
	if found_total == 0:
		push_warning("NodeFinder: E9 The key: [" + key + "]  was not found")
		return null
	if found_total > 1:
		if not suppress:
			push_warning("NodeFinder: E10 The key: [" + key + "]  was found multiple times. The results have been returned as an array instead of a node. Calling this function with the second arg as true will suppress this warning.")
		var arr = []
		for scn in scene:
			arr.append(NODES[scn][key])
		return arr
	return NODES[scene.front()][key]
	
func register(key: String,node: Node):
	var scene = belongs_to_scene(node)
	if scene == null:
		push_warning("NodeFinder: E3 Couldn't get the scene root of this node, node: "+node.name + str(node))
		return
	if NODES[scene].has(key):
		push_warning("NodeFinder: E8 The key: [" + key + "]  is already in use. If you wish to override, use .override( KEY, NODE ) instead.")
		return
	new_registry(scene, key, node)
	
func override(key: String,node: Node):
	var scene = belongs_to_scene(node)
	if scene == null:
		push_warning("NodeFinder: E3 Couldn't get the scene root of this node, node: "+node.name + str(node))
		return
	new_registry(scene, key, node)

func unregister(key: String, root: Node = null):
	var scene
	if root == null:
		var found_total = 0
		for scn in SCENES:
			if !NODES.has(scn):
				push_warning("NodeFinder: E4 The root node of this object is not registered")
				return
			for key_in_scene in NODES[scn].keys():
				if key_in_scene == key:
					scene = scn
					found_total += 1
		if found_total == 0:
			push_warning("NodeFinder: E5 The key: [" + key + "]  could not be found")
			return
		if found_total > 1:
			push_warning("NodeFinder: E6 The key: [" + key + "]  has been used more than once. If different nodes in different scenes have the same key, you must specificy the root node of the scene as the second argument")
			return
	else:
		scene = root
		if !NODES.has(scene):
				push_warning("NodeFinder: E7 The provided root is not registered")
				return
	if scene == null:
		push_warning("Couldn't get the scene root of this node")
		return
	erase_registry(scene, key)

var finder = []
#DO NOT USE MANUALLY#
func recursive_finder(node, nodename):
	if node.name == nodename:
		finder.append(node)
	if node.get_child_count()>0:
		for ch in node.get_children():
			recursive_finder(ch,nodename)
	var copy = finder.duplicate()
	finder.clear()
	return 
	
func get_named(nodename: String, suppress: bool = false):
	var scene 
	var found_total = 0
	for scn in SCENES:
		if !NODES.has(scn):
			push_warning("NodeFinder: E4 The root node of this object is not registered")
			return
		scene = recursive_finder(scn, nodename)
		found_total += 1
	
	if found_total == 0:
		push_warning("NodeFinder: E11 The node named [ " + nodename + " ]  was not found")
		return null
	if found_total > 1:
		if not suppress:
			push_warning("NodeFinder: E12 The node named [ " + nodename + " ]  was found multiple times. The results have been returned as an array instead of a node. Calling this function with the second arg as true will suppress this warning.")
		return scene
	return scene.front()

