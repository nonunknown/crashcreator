extends Panel

onready var manager_editor:EditorManager = get_node("/root/Main")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_bt_edit_path_toggled(button_pressed):
	if (button_pressed):
		manager_editor.emit_signal("change_mode",Utils.EDITOR_STATE.PATH)
	pass # Replace with function body.


func _on_bt_edit_crate_toggled(button_pressed):
	if (button_pressed):
		manager_editor.emit_signal("change_mode",Utils.EDITOR_STATE.CRATE)

func _on_bt_edit_item_toggled(button_pressed):
	if (button_pressed):
		manager_editor.emit_signal("change_mode",Utils.EDITOR_STATE.ITEM)


func _on_bt_edit_enemy_toggled(button_pressed):
	if (button_pressed):
		manager_editor.emit_signal("change_mode",Utils.EDITOR_STATE.ENEMY)


func _on_bt_edit_time_toggled(button_pressed):
	if (button_pressed):
		manager_editor.emit_signal("change_mode",Utils.EDITOR_STATE.TIME)


func _on_bt_edit_save_pressed():
	manager_editor.emit_signal("change_mode",Utils.EDITOR_STATE.SAVE)
	pass # Replace with function body.


func _on_bt_edit_load_pressed():
	manager_editor.emit_signal("change_mode",Utils.EDITOR_STATE.LOAD)
	pass # Replace with function body.


func _on_bt_edit_new_pressed():
	manager_editor.emit_signal("change_mode",Utils.EDITOR_STATE.NEW)
	pass # Replace with function body.


func _on_popup_save_id_pressed(id):
	print(id)
	pass # Replace with function body.

signal popup_entity
func _on_bt_edit_entity_toggled(button_pressed):
	if (button_pressed):
		manager_editor.emit_signal("change_mode",Utils.EDITOR_STATE.ENTITY)
		emit_signal("popup_entity")



onready var level_builder:LevelBuilder = get_node("/root/Main/Builder") as LevelBuilder
onready var gui_build = get_parent().get_node("GUI_Build")
func _on_bt_edit_export_pressed():
	gui_build.show()
	gui_build.set_builder(level_builder)
#	level_builder.start(true)
