extends Spatial
class_name Selectable

export var show_name:String = "Define_selectable_name"
export var mat_selection:SpatialMaterial = load("res://models/levels/shared/mat_selection.material")
enum ST {UNSELECTED,SELECTED}




func st_init_unselected():
	$model.set_material_override(null)

func st_init_selected():
	print("selected")
	$model.set_material_override(mat_selection)
	
var manager:Utils.MachineManager
func _on_ready():
	manager = Utils.MachineManager.new()
	manager.register_state(self,ST.SELECTED,"selected")
	manager.register_state(self,ST.UNSELECTED,"unselected")
	
	# manager.states[ST_SELECTED] = St_selected.new(manager)

func to_selected():
	manager.change_state(ST.SELECTED)
	
func to_unselected():
	manager.change_state(ST.UNSELECTED)
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
