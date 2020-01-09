extends Button

signal project_save
onready var manager_editor:EditorManager = get_node("/root/Main")

func _ready():
	#manager_editor.connect("change_mode",self,"tool_changed")
	pass # Replace with function body.

func start():
	emit_signal("project_save")
	save_scene()
	
	pass

func exit():
	pass
	
func update():
	pass

func save_scene():
	var packed_scene = PackedScene.new()
	var level = get_node("/root/Main/Level")
	var childs = level.get_children()
	recursive_owner(childs,level)
	packed_scene.pack(level)
	ResourceSaver.save("user://temp.tscn",packed_scene)
	print("saved successfully")

func recursive_owner(childs,owner):
	for child in childs:
		if (child.is_in_group("dont_save")):
			print("find one in dont save")
		else:
			child.set_owner(owner)
			if (child.get_child_count() > 0):
				recursive_owner(child.get_children(),owner)

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
