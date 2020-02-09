tool
extends EditorPlugin
class_name BetterGroups
# A class member to hold the dock during the plugin life cycle
var dock

func _enter_tree():
	# Initialization of the plugin goes here
	# Load the dock scene and instance it
	print("Started Group Manager")
	dock = load("res://addons/better_groups/Main.tscn").instance()
	var bt_list = dock.get_child(0)
	bt_list.set_bg(self)
	# Add the loaded scene to the docks
	add_control_to_dock(DOCK_SLOT_RIGHT_UR, dock)
	# Note that LEFT_UL means the left of the editor, upper-left dock

func _exit_tree():
	# Clean-up of the plugin goes here
	# Remove the dock
	remove_control_from_docks(dock)
	 # Erase the control from the memory
	dock.

func list_groups():
	print( str ( get_tree().root ) )
