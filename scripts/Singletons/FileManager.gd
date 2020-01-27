extends Node

var dir:Directory = Directory.new()

func _init():
	check_dir("projects")
	check_dir("custom_level")
	
func check_dir(folder_name:String):
	var err = dir.open("user://"+folder_name)
	if err == OK:
		print("already exists")
	else:
		dir.open("user://")
		dir.make_dir(folder_name)
