extends Spatial
class_name EnemyManager

var editor_state:EditorState

func _ready():
	editor_state = EditorState.new(Utils.EDITOR_STATE.ENEMY,self)

func _enter():
	print("entered")
	pass

func _update():
	pass

func _exit():
	pass
