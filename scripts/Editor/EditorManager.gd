extends Node
class_name EditorManager

signal change_mode
signal tool_changed
signal tool_exited
signal tool_started

onready var smachine:Utils.MachineManager = Utils.MachineManager.new()
var logger:Logger
var registered_managers = {}

func _ready():
	logger =  get_node("GUI/GUI_Logger/Logger")
	smachine.register_state_array(self,[Utils.EDITOR_STATE.PATH,
	Utils.EDITOR_STATE.CRATE,Utils.EDITOR_STATE.ENTITY,Utils.EDITOR_STATE.TIME,Utils.EDITOR_STATE.SAVE,Utils.EDITOR_STATE.LOAD,Utils.EDITOR_STATE.NEW],
	["path","crate","entity","time","save","load","new"])
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

func st_init_save():
	registered_managers[Utils.EDITOR_STATE.SAVE]._enter()
	pass

func st_update_save():
	registered_managers[Utils.EDITOR_STATE.SAVE]._update()
	pass

func st_exit_save():
	registered_managers[Utils.EDITOR_STATE.SAVE]._exit()
	pass
	
func st_init_load():
	registered_managers[Utils.EDITOR_STATE.LOAD]._enter()
	pass

func st_update_load():
	registered_managers[Utils.EDITOR_STATE.LOAD]._update()
	pass

func st_exit_load():
	registered_managers[Utils.EDITOR_STATE.LOAD]._exit()
	pass

func st_init_new():
	registered_managers[Utils.EDITOR_STATE.NEW]._enter()
	pass

func st_update_new():
	registered_managers[Utils.EDITOR_STATE.NEW]._update()
	pass

func st_exit_new():
	registered_managers[Utils.EDITOR_STATE.NEW]._exit()
	pass
