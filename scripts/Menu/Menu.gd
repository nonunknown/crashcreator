extends Control
class_name Menu

signal done

export var wait_time:float = 1
export var wait_for_input:bool = false

func _ready():
	get_parent().add_menu(self)
	
func start():
	visible = true
	pass
	
func finish():
	visible = false
	pass

func is_done() -> Object:
	return self
