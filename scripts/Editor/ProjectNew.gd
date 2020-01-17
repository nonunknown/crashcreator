extends Button

var editor_state:EditorState

func _ready():
	connect("pressed",self,"_on_pressed")
	editor_state = EditorState.new(Utils.EDITOR_STATE.NEW,self)

func _enter():
	GameManager.change_scene_forced("res://scenes/scn_LevelEditor.tscn", GameManager.MODE.EDIT)	
	pass
	
func _update():
	pass
	
func _exit():
	pass
