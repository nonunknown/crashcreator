extends Spatial
class_name LevelManager

onready var path_manager = $Path
onready var crate_manager = $Crate
onready var entity_manager = $Entity
onready var enemy_manager = $Enemy

var project:Project = null

func insert_stuff(_project:Project):
	self.project = _project
	path_insertion()
	crate_insertion()
	entity_insertion()

func path_insertion():
	path_manager.reset()
	for path_dir in project.path_models:
		path_manager.auto_spawn_path(path_dir)

func crate_insertion():
	crate_manager.reset()
	for i in project.crate_ids.size():
		print("crate_insertion: "+str(i))
		
		print(str(project.crate_ids[i]))
		print(str(project.crate_time_ids[i]))
		print(str(project.crate_pos[i]))
		crate_manager.spawn_crate(project.crate_ids[i],project.crate_time_ids[i],project.crate_pos[i])

func entity_insertion():
	entity_manager.reset()
	for i in project.entity_ids.size():
		entity_manager.set_entity(project.entity_ids[i], project.entity_pos[i])
	pass

func enemy_insertion():
	enemy_manager.reset()
	for i in project.enemy_ids.size():
		enemy_manager.spawn_enemy(project.enemy_ids[i],project.enemy_pos[i])
