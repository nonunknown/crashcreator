extends Panel


enum { PATH,CRATE,ITEM,ENEMY,TIME}

onready var manager_editor:EditorManager = get_node("/root/Main")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_bt_edit_path_toggled(button_pressed):
	if (button_pressed):
		manager_editor.emit_signal("change_mode",PATH)
	pass # Replace with function body.


func _on_bt_edit_crate_toggled(button_pressed):
	if (button_pressed):
		manager_editor.emit_signal("change_mode",CRATE)

func _on_bt_edit_item_toggled(button_pressed):
	if (button_pressed):
		manager_editor.emit_signal("change_mode",ITEM)


func _on_bt_edit_enemy_toggled(button_pressed):
	if (button_pressed):
		manager_editor.emit_signal("change_mode",ENEMY)


func _on_bt_edit_time_toggled(button_pressed):
	if (button_pressed):
		manager_editor.emit_signal("change_mode",TIME)
