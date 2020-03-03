extends Spatial
class_name EnemyManager

var editor_state:EditorState
var editor_enemy = load("res://resources/editor/EditorEnemy.res")
var selected_enemy = null
func _ready():
	editor_state = EditorState.new(Utils.EDITOR_STATE.ENEMY,self)

func _enter():
	
	pass

var last_pos:Vector3 = Vector3.ZERO
func _update():
	var pos = last_pos
	if (!Utils.ray_dict.empty()):
		#var v = Utils.ray_dict.position / tile_size
		pos = Utils.ray_dict.position
	if selected_enemy != null:
		selected_enemy.translation = pos
	
	last_pos = pos
	
	if Input.is_action_just_pressed("mouse_left_button") && selected_enemy != null && !Utils.ray_dict.empty():
		pos = pos +Vector3.UP * .5
		spawn_enemy(-1,pos)
	
	pass
func _exit():
	selected_enemy = null
	pass

func spawn_enemy(_id:int=-1,_pos:Vector3=Vector3.ZERO):
	if _id == -1: _id = selected_enemy._ID
	var e = selected_enemy.duplicate()
	e.config(_id)
	add_child(e)
	e.translation = _pos
	pass

func _on_set_enemy(_id):
	if selected_enemy == null:
		selected_enemy = editor_enemy.instance()
		add_child(selected_enemy)
	selected_enemy.config(_id)
	pass
