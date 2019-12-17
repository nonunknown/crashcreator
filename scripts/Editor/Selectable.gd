extends Spatial

export var show_name:String = "Define_selectable_name"

enum {ST_UNSELECTED,ST_SELECTED}

class St_unselected extends Utils.FSM:
	
	func name():
		return "unselected"

	func _on_enter():
		manager.node.get_child(0).material_override = null

class St_selected extends Utils.FSM:
	func name():
		print("selected:  mudafucka")

	func _on_enter():
		manager.node.get_child(0).material_override = SpatialMaterial.new()

var st_manager = null
func _on_ready():
	st_manager = Utils.FSM_Manager.new()
	st_manager.set_node(self)
	st_manager.states[ST_UNSELECTED] = St_unselected.new()
	st_manager.states[ST_UNSELECTED].set_manager(st_manager)
	st_manager.states[ST_SELECTED] = St_selected.new()
	st_manager.states[ST_SELECTED].set_manager(st_manager)
	st_manager.current = st_manager.states[ST_UNSELECTED]
	# manager.states[ST_SELECTED] = St_selected.new(manager)

	# manager.current = manager.states[ST_UNSELECTED]
# class FSM_Manager:
# 	var states:Dictionary = {}
# 	var state_current = null
# 	enum {UNSELECTED,SELECTED}

# 	func state_change(to):
# 		state_current._on_exit()
# 		state_current = to
# 		state_current._on_enter()

# 	func _init():
# 		#SelectionManager.connect("_selection_changed",self,"_on_selection_changed")
# 		print(self)
# 		states[UNSELECTED] = St_unselected.new(self)
# 		states[SELECTED] = St_selected.new(self)
# 		state_current = states[UNSELECTED]

# 	func _input(event):
# 		state_current._input(event)

# class FSM:
# 	var manager = null
	
# 	func _init(man):
# 		manager = man

	
# 	func name():
# 		return "define"

# 	func _on_enter():
# 		pass
	
# 	func _update():
# 		pass
	
# 	func _on_exit():
# 		pass

# 	func _input(event):
# 		pass
	



# var manager = FSM_Manager.new()



# func _input(event):
# 	manager._input(event)


# func _on_selection_changed():
# 	print("OnSelectionChange signal executed fine!!!")
# 	if (SelectionManager.selected_single == self):
# 		state_change(states[SELECTED])
# 	else: $Model.material_override = null
