extends Spatial

class FSM:
	func name():
		return "define"

	func _on_enter():
		pass
	
	func _update():
		pass
	
	func _on_exit():
		pass

	

class St_unselected extends FSM:
	func name():
		return "unselected"

class St_selected extends FSM:
	func name():
		return "selected"

	func _on_enter():
		print("selected:  mudafucka")

var states:Dictionary = {}
var state_current = null
enum {UNSELECTED,SELECTED}

func state_change(to):
	state_current._on_exit()
	state_current = to
	state_current._on_enter()

export var use_onready:bool
func _on_ready():
	if !use_onready: return
	SelectionManager.connect("_selection_changed",self,"_on_selection_changed")
	states[UNSELECTED] = St_unselected.new()
	states[SELECTED] = St_selected.new()
	state_current = states[UNSELECTED]

func _input(event):
	#if state_current == states[SELECTED]: return
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and mouse_over_me:
			SelectionManager.update_single_selection(self)
			$Model.material_override = SpatialMaterial.new()
			

func _process(delta):
	state_current._update()

# enum STATE {UNSELECTED,SELECTED}
# var state_machine = STATE.UNSELECTED

# func sm_transition(to):
# 	state_machine = to

# func _on_clicked():
# 	match(state_machine):
# 		STATE.UNSELECTED:
# 			sm_transition(STATE.SELECTED)
# 	pass
func _on_selection_changed():
	print("OnSelectionChange signal executed fine!!!")
	if (SelectionManager.selected_single == self):
		state_change(states[SELECTED])
	else: $Model.material_override = null

var mouse_over_me = false
func _on_StaticBody_mouse_entered():
	mouse_over_me = true

func _on_StaticBody_mouse_exited():
	mouse_over_me = false
	pass # Replace with function body.
