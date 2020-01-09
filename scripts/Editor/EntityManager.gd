extends Spatial
class_name EntityManager

export var entity_start:PackedScene
export var entity_finish:PackedScene
var ent_start_instance = null
var ent_finish_instance = null
var holding_entity = null
var editor_state:EditorState
var placed_entities = {start=null,end=null}
func _ready():
	editor_state = EditorState.new(Utils.EDITOR_STATE.ENTITY,self)
#	get_tree().get_nodes_in_group("popup_entity")[0].connect("entity",self,"set_entity")
	Utils.connect("mouse_left_clicked",self,"_on_mouse_left_clicked")
#called from editor_state
func check_instance():
	if (ent_finish_instance == null or ent_start_instance == null):
		ent_start_instance = entity_start.instance()
		ent_start_instance.add_to_group("entity_start")
		ent_finish_instance = entity_finish.instance()
		ent_start_instance.add_to_group("entity_finish")
		

func set_entity(id):
	match(id):
		0:
			
			holding_entity = ent_start_instance
			
		1:
			holding_entity = ent_finish_instance
	
	add_child(holding_entity)

func _enter():
	check_instance()
	pass

func _update():
	if (holding_entity != null and !Utils.ray_dict.empty()):
		holding_entity.translation = Utils.ray_dict.position

func _exit():
	print("exit entity")
	pass

func spawn_entity():
	holding_entity = null

func _on_mouse_left_clicked():
	if editor_state.get_current_state() == Utils.EDITOR_STATE.ENTITY and holding_entity != null:
		spawn_entity()
