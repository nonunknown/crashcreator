extends Node
class_name EditorManager

signal change_mode
signal tool_changed
signal tool_exited
signal tool_started

onready var smachine:Utils.MachineManager = Utils.MachineManager.new()
var registered_managers = {}

func _ready():
	smachine.register_state_array(self,[Utils.EDITOR_STATE.PATH,
	Utils.EDITOR_STATE.CRATE,Utils.EDITOR_STATE.ENTITY,Utils.EDITOR_STATE.TIME],
	["path","crate","entity","time"])
	connect("change_mode",self,"_on_change_mode")
	emit_signal("change_mode",Utils.EDITOR_STATE.PATH)


func _process(_delta):
	smachine.machine_update()

func _on_change_mode(_tool):
	emit_signal("tool_exited",smachine.machine.state)
	smachine.change_state(_tool)
	emit_signal("tool_started",_tool)
	
#func change_tool(_tool):
#	smachine.change_state(_tool)

func st_init_path():
	registered_managers[Utils.EDITOR_STATE.PATH]._enter()
	pass

func st_update_path():
	registered_managers[Utils.EDITOR_STATE.PATH]._update()
	pass

func st_exit_path():
	registered_managers[Utils.EDITOR_STATE.PATH]._exit()
	pass

func st_init_crate():
	registered_managers[Utils.EDITOR_STATE.CRATE]._enter()
	pass

func st_update_crate():
	registered_managers[Utils.EDITOR_STATE.CRATE]._update()
	pass

func st_exit_crate():
	registered_managers[Utils.EDITOR_STATE.CRATE]._exit()
	pass

func st_init_entity():
	registered_managers[Utils.EDITOR_STATE.ENTITY]._enter()
	pass

func st_update_entity():
	
	registered_managers[Utils.EDITOR_STATE.ENTITY]._update()
	pass

func st_exit_entity():

	
	registered_managers[Utils.EDITOR_STATE.ENTITY]._exit()
	pass

func st_init_time():
	registered_managers[Utils.EDITOR_STATE.TIME]._enter()
	pass

func st_update_time():
	
	registered_managers[Utils.EDITOR_STATE.TIME]._update()
	pass

func st_exit_time():
	registered_managers[Utils.EDITOR_STATE.TIME]._exit()
	pass
