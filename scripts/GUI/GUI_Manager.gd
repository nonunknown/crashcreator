extends Control

export var bts_menu:ButtonGroup

onready var gui_path_properties:Control = $GUI_path_properties
onready var gui_path_tools:Control = $GUI_tools_path
onready var gui_crate_tools:Control = $GUI_tools_crate
onready var gui_list:Array = [gui_path_tools,gui_crate_tools]

onready var manager_editor:EditorManager = get_node("/root/Main")
#onready var manager_level:Node = get_node("../Level")
#onready var manager_path:Node = get_node("../Level/Path")
#onready var manager_crate:Node = get_node("../Level/Crate")
#enum TOOL {PATH,CRATE}
#var statem:Utils.MachineManager
#var selected_tool = TOOL.PATH


func _ready():
	manager_editor.connect("tool_changed",self,"_on_tool_changed")
	
func _on_tool_changed(_tool):
	clear(gui_list[_tool])
	pass
#
#	statem = Utils.MachineManager.new()
#	statem.register_state(self,TOOL.PATH,"path",true,true)
#	statem.register_state(self,TOOL.CRATE,"crate",true,true)
#	tool_windows = [gui_path_tools,gui_crate_tools]
#	connect("selected_tool_changed",manager_level,"tool_changed")
#
#	statem.change_state(TOOL.PATH)
	pass


#func _process(delta):
#	statem.machine_update()

#func st_init_path():
#	manager_path._start()
#
#func st_update_path():
#	pass
#
#func st_exit_path():
#	manager_path._exit()
#
#func st_init_crate():
#	manager_crate._start()
#	pass
#
#func st_update_crate():
#	manager_crate._update()
#
#func st_exit_crate():
#	manager_crate._exit()
#
func clear(except=null):
	for gui in gui_list:
		if (gui == except):
			gui.visible = true
			continue
		gui.visible = false
#
#signal selected_tool_changed


#func _on_tool_changed(_tool):
#	clear(gui_list[_tool])
#	visible_gui.visible = true
#	statem.change_state(tool_name)
#	emit_signal("selected_tool_changed",tool_name)

#func _on_bt_edit_path_toggled(button_pressed):
#	if (button_pressed):
#		tool_change(gui_path_tools,TOOL.PATH)
		
#func _on_bt_edit_crate_toggled(button_pressed):
#	if (button_pressed):
#		manager_editor.emit_signal("_change_mode",GameManager.EDITMODE.PATH)
##		tool_change(gui_crate_tools,TOOL.CRATE)
#		pass
