extends Spatial
class_name EntityManager

export var entity_start:PackedScene
export var entity_finish:PackedScene
export var entity_clock:PackedScene

#var ent_start_instance = null
#var ent_finish_instance = null
var entities_instance:Array = []
var holding_entity = null
var editor_state:EditorState
#var placed_entities = {start=null,end=null}

var manager_editor:EditorManager

func _ready():
	editor_state = EditorState.new(Utils.EDITOR_STATE.ENTITY,self)
	entities_instance = [entity_start.instance(),entity_finish.instance(),entity_clock.instance()]
	manager_editor = editor_state.manager_editor

func set_entity(id:int, pos:Vector3=Vector3.ZERO):
	holding_entity = entities_instance[id]
	add_child(holding_entity)
	if pos != Vector3.ZERO:
		holding_entity.translation = pos
	

func _enter():
	manager_editor.logger.logg("Editing: Entities")
	pass

func _update():
	if holding_entity == null: return
	if  !Utils.ray_dict.empty():
		holding_entity.translation = Utils.ray_dict.position
	if Input.is_action_just_pressed("mouse_left_button"):
		spawn_entity()

func _exit():
	print("exit entity")
	pass

func spawn_entity():
	holding_entity = null
	
func reset():
	var children = get_children()
	for child in children:
		child.queue_free()
	holding_entity = null
	
