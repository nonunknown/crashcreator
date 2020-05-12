extends Spatial
class_name Selectable

export var file_path:String
export var show_name:String = "Define_selectable_name"
export var mat_selection:SpatialMaterial = load("res://models/levels/shared/mat_selection.material")
enum ST {UNSELECTED,SELECTED}


func st_init_unselected():
	$model.set_material_override(null)

func st_init_selected():
	print("selected")
	$model.set_material_override(mat_selection)
	
var manager:StateMachine
func _on_ready():
	manager = StateMachine.new(self)
	manager.register_state(ST.SELECTED,"selected")
	manager.register_state(ST.UNSELECTED,"unselected")
	
	# manager.states[ST_SELECTED] = St_selected.new(manager)

func to_selected():
	manager.change_state(ST.SELECTED)
	
func to_unselected():
	manager.change_state(ST.UNSELECTED)

