extends Node
class_name GUI_tools_Manager

var editor_manager
var target:Node
var id:int

func _init(_id:int,_target:Node):
	self.target = _target
	self.id = _id
	
func _ready():
	editor_manager = target.get_node("/root/Main")
	editor_manager.connect("tool_exited",self,"_on_tool_exited")
	editor_manager.connect("tool_started",self,"_on_tool_started")
	pass
	
func _on_tool_exited(_id):
	print(str(_id)+" / "+str(id))
	if (_id == id ):
		target._on_tool_exited()
	pass
	
func _on_tool_started(_id):
	if (_id == id):
		target._on_tool_started()
	pass
