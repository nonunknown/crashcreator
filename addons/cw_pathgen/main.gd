tool
extends EditorPlugin

var dock

func _enter_tree():
	dock = preload("res://addons/cw_pathgen/gui/gui_main.scn").instance()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_UL,dock)
	pass

func _exit_tree():
	remove_control_from_docks(dock)
	dock.free()
	pass
