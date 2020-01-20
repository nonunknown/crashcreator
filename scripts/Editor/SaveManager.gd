extends ConfirmationDialog

var editor_state:EditorState
onready var project_name:LineEdit = $Control/le_proj_name
onready var checkbox_overwrite:CheckBox = $Control/CheckBox

func _ready():
	editor_state = EditorState.new(Utils.EDITOR_STATE.SAVE,self)
	connect("confirmed",self,"_on_SaveDialog_confirmed")
	checkbox_overwrite.connect("toggled",self,"_on_CheckBox_toggled")
	pass
	
func _enter():
	show()
	
	pass
	
func _update():
	pass
	
func _exit():
	pass
# SAVE ----
var overwrite:bool = false
var output:String = ""

func is_project_name_valid()->bool:
	if project_name.text.length() == 0:
		editor_state.manager_editor.logger.logg("Warning: Project Name cant be empty!")
		return false
	if project_name.text.length() < 4:
		editor_state.manager_editor.logger.logg("Warning: Project name needs at least 4 characters!")
		return false
	for letter in project_name.text:
		if letter == " ":
			editor_state.manager_editorr.logger.logg("Warning: Project name cant contain spaces!")
			return false
	return true
	
var packed_scene:PackedScene
func save_file() -> bool:
	var path_manager_children = get_tree().get_nodes_in_group("path_manager")[0].get_children()
	var crate_manager_children = get_tree().get_nodes_in_group("crate_manager")[0].get_children()
	var entity_manager_children = get_tree().get_nodes_in_group("entity_manager")[0].get_children()
	save_level(project_name.text,path_manager_children,crate_manager_children,entity_manager_children)
	return true

func save_level(project_name:String, paths:Array,crates:Array,entities:Array):
	var project:Project = Project.new()
	save_path(project,paths)
	save_crates(project,crates)
	save_entities(project,entities)
	var save_dir = "user://projects/"+project_name+".cwproj"
	var save_game = File.new()
	save_game.open(save_dir, File.WRITE)
	save_game.store_line(to_json(project.to_dict()))
	save_game.close()

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
		project.crate_ids.append( crate._ID )
		project.append_crate_pos(crate.translation)
		project.crate_time_ids.append( crate._time_ID )
		
	pass

func save_entities(project:Project, entities:Array):
	if entities.size() == 0: return
	for entity in entities:
		project.entity_ids.append(entity._ID)
		project.append_entity_pos(entity.translation)
	pass

func get_paths_array() -> Array:
	var paths:Array = []
	var path_manager = get_tree().get_nodes_in_group("path_manager")[0]
	for child in path_manager.get_children():
		paths.append(child.file_path)
	return paths

func _on_SaveDialog_confirmed():
	if !is_project_name_valid():
		return
	if !save_file():
		return
	editor_state.manager_editor.logger.logg("Success: Project Saved")
	pass # Replace with function body.

func _on_CheckBox_toggled(button_pressed):
	overwrite = button_pressed
	editor_state.manager_editor.logger.logg("Overwrite set to: "+str(overwrite))
	pass # Replace with function body.
