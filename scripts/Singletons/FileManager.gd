extends Node

var project_dir = "user://projects/"


func save_level(project_name:String, paths:Array,crates:Array,entities:Array):
	var project:Project = Project.new()
	save_path(project,paths)
#	save_crates(project,crates)
#	save_entities(project,entities)
	var save_dir = project_dir+project_name+".tres"
	
	var err = ResourceSaver.save(save_dir,project)
	if err == OK:
		print("saved")
	else:
		print("Error saving: "+str(err) )
#	level_data.paths = paths
#	var save_game = File.new()
#	save_game.open(project_dir+project_name+".proj", File.WRITE)
#	save_game.store_line(to_json(level_data))
#	save_game.close()

func save_path(project:Project, paths:Array):
	if paths.size() == 0: return
	print(paths.size())
	for path in paths:
		var dir = path.file_path
		project.path_models.append(dir)
	pass
	
func save_crates(project:Project, crates:Array):
	if crates.size() == 0: return
	for crate in crates:
		project.crate_ids.append( crate.ID)
		project.crate_pos.append( crate.translation )
		project.crate_time_ids.append(crate._timeID )
	pass

func save_entities(project:Project, entities:Array):
	if entities.size() == 0: return
	for entity in entities:
		project.entity_ids.append(entity._ID)
		project.entity_pos.append(entity.translation)
	pass

func load_project(file_path:String):
	var project:Project = ResourceLoader.load(file_path)
	
	pass
