extends AcceptDialog

var editor_state:EditorState
onready var item_list:ItemList = $Control/ProjectList

var selected_item:String = ""

func _ready():
	editor_state = EditorState.new(Utils.EDITOR_STATE.LOAD,self)
	connect("confirmed",self,"_on_confirmed")
	item_list.connect("item_selected",self,"_on_selected")
	
func _enter():
	if not GameManager.GAME_MODE == GameManager.MODE.LOAD:
		load_project_files()
		show()
	else:
		load_project_into_editor()
	pass
	
func _update():
	pass
	
func _exit():
	pass

func load_project_files():
	print("loading")
	var dir:Directory = Directory.new()
	if dir.open("user://projects") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			print("iteration")
			if not dir.current_is_dir():
				add_item(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func add_item(name):
	item_list.add_item(name)
	pass

func load_project():
	var dir = "user://projects/"+selected_item
	GameManager.load_project(dir)
	
func _on_confirmed():
	if selected_item == "":
		editor_state.manager_editor.logger.logg("Error: There is no selected project")
		return
	load_project()
	
	pass
	
func _on_selected(index:int):
	selected_item = item_list.get_item_text(index) 
	editor_state.manager_editor.logger.logg("Selected: "+selected_item)
	pass

func load_project_into_editor():
	print("loading into editor")
	editor_state.manager_editor.logger.logg("Loading: project into directory")
	FileManager.load_project(GameManager.path_to_project)
	pass
