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
	
	FileManager.save_level(project_name.text,path_manager_children,crate_manager_children,entity_manager_children)
	return true
#	packed_scene = PackedScene.new()
#
#	var name = project_name.text + ".tscn"
#	execute_save_system()
#	var err = ResourceSaver.save("user://projects/"+name,packed_scene)
#	if (err == OK):
#		return true
#	editor_state.manager_editor.logger.logg("Error: SAVING "+str(err))
#	return false

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
