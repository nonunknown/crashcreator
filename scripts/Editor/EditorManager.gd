extends Node
class_name EditorManager

signal change_mode
signal tool_changed

onready var smachine:Utils.MachineManager = Utils.MachineManager.new()
enum { PATH,CRATE,ITEM,ENEMY,TIME}

func _ready():
	smachine.register_state(self, PATH, "path" ,true, true)
	smachine.register_state(self, CRATE, "crate", true, true)
	change_tool(PATH)
	connect("change_mode",self,"_on_change_mode")
	pass

func _on_change_mode(_tool):
	change_tool(_tool)
	
func change_tool(_tool):
	print("test")
	smachine.change_state(_tool)
	emit_signal("tool_changed",_tool)

func st_init_path():
	pass

func st_update_path():
	pass

func st_exit_path():
	pass

func st_init_crate():
	pass

func st_update_crate():
	pass

func st_exit_crate():
	pass

#func st_init_():
#	pass
#
#func st_update_():
#	pass
#
#func st_exit_():
#	pass
