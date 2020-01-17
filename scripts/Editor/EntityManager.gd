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

func set_entity(id):
	holding_entity = entities_instance[id]
	add_child(holding_entity)

func _enter():
	manager_editor.logger.logg("Editing: Entities")
	pass

func _update():
	if holding_entity == null: return
	if  !Utils.ray_dict.empty():
		holding_entity.translation = Utils.ray_dict.position
	if Utils.mouse_left_clicked():
		spawn_entity()

func _exit():
	print("exit entity")
	pass

func spawn_entity():
	holding_entity = null
