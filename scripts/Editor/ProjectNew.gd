extends Button

signal project_new

onready var manager_editor:EditorManager = get_node("/root/Main")

func _ready():
	#manager_editor.connect("change_mode",self,"tool_changed")
	pass # Replace with function body.

func tool_changed(_tool):
	if (_tool == 5):
		manager_editor.init_func = funcref(self,"start")
		manager_editor.update_func = funcref(self,"update")
		manager_editor.exit_func = funcref(self,"exit")

func start():
	print("clicked")
	emit_signal("project_new")
	var level = get_node("/root/Main/Level")
	for child in level.get_children():
		for c in child.get_children():
			c.queue_free()
	get_tree().get_root().get_camera().translation = Vector3.ZERO
	
func update():
	pass
	
func exit():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
