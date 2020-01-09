extends Button

signal project_load

onready var manager_editor:EditorManager = get_node("/root/Main")

func _ready():
	#manager_editor.connect("change_mode",self,"tool_changed")
	pass # Replace with function body.

func tool_changed(_tool):
	if (_tool == 7):
		manager_editor.init_func = funcref(self,"start")
		manager_editor.update_func = funcref(self,"update")
		manager_editor.exit_func = funcref(self,"exit")

func start():
#	get_tree().get_nodes_in_group("gp_level")[0].queue_free()
	emit_signal("project_load")
	var scn = load("user://temp.tscn").instance()
	get_node("/root/Main/Level").queue_free()
	get_node("/root/Main").add_child(scn)
	
#	delete.queue_free()
	
	pass

func exit():
	pass
	
func update():
	pass
