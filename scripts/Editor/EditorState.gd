extends Node
class_name EditorState

var manager_editor:EditorManager
var _toolID = -1
var target = null


func _init(toolID,_target):
	self.target = _target
	manager_editor = target.get_node("/root/Main")	
	manager_editor.registered_managers[toolID] = self.target
	_toolID = toolID

	
func get_current_state() -> int: return manager_editor.smachine.get_current_state()


#func _start():
#	print("implement me: start")
#
#func _update():
#	print("implement me: update")
#
#func _exit():
#	print("implement me: exit")
