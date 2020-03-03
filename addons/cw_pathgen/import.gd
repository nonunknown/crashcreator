tool
extends Control

var importing:bool = false
var paths:Array = []
onready var logger:TextEdit = $ItemList/Logger



func do_import():
	importing = true
	logg("Started importing...")
	if check_input_dir() == null: return
	check_files_structure()
	

func check_input_dir():
	var dir:Directory = Directory.new()
	logg("opening dir input")
	if (dir.open("res://path_gen/input") == OK):
		logg("oppened successfully!")
		dir.list_dir_begin()
		var file = dir.get_next()
		while(file != ""):
			if !dir.current_is_dir():
				if file.ends_with(".dae"):
					paths.append(file)
					logg("found valid: "+str(file))
				else:
					logg("found invalid: "+str(file))
			file = dir.get_next()
		if (paths.size() == 0):
			exit("error > folder input is empty")
			return null
		else:
			logg("got all input files successfully")
			return 0
	else: 
		exit("error opening dir res://path_gen/input")
		return null

func check_files_structure():
	logg("checking files structure")
	var pathchecker:Node = get_tree().root.add_child(Node.new())
	print(paths)
	for path in paths:
		var ps:PackedScene = load("res://path_gen/input/"+path)
		var inst = ps.instance()
		pathchecker.add_child(inst)
		print(print_tree_pretty())
	pathchecker.queue_free()
	
func exit(error:String):
	logg("exited with error:")
	logg(error)
	set_importing(false)

func logg(text:String):
	logger.text += "\n"+str(text)
	
func set_importing(value:bool):
	importing = value
	$ItemList/bt_import.visible = !value
	
func _on_bt_import_pressed():
	if (!importing):
		logger.text = ""
		set_importing(true)
		do_import()
	else:
		logg("Already importing wait...")
	pass # Replace with function body.
