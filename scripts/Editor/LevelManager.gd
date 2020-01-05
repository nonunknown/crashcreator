extends Spatial

onready var manager_editor:EditorManager = get_node("/root/Main")
var _tool:int = 0

enum {PATH,CRATE}

func _ready():
	manager_editor.connect("change_mode",self,"tool_changed")

func _unhandled_input(event):
	match _tool:
		PATH: path_event(event)
		CRATE: crate_event(event)
	
func tool_changed(_tool):
	self._tool = _tool
	
func path_event(event):
	
	if (Utils.mouse_left_clicked(event)):
		print("clicked")
		var r = Utils.ray_mouse_to_world(event,get_viewport().get_camera(),get_world(),Utils.MASK.Selectable)
		var result = null
		if (!r.empty()):
			result = r.collider.get_path()
		SelectionManager.selection_set_single(result)

func crate_event(event):
	if (Utils.mouse_left_clicked(event)):
		print("crate clicked")
	pass
