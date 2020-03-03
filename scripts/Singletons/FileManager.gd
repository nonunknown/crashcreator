extends Node

class EditorLevelInfo:
	var filename:String setget ,get_str
	
	func get_str()->String:
		return filename.trim_suffix(".cwproj")
		
	func _init(_filename:String):
		self.filename = _filename
		pass

var user_dir:Dictionary = {
	project = "user://projects",
	custom_level = "user://custom_level"
}

var dir:Directory = Directory.new()
var editingLevel:EditorLevelInfo


func _init():
	check_dir("projects")
	check_dir("custom_level")
	
func check_dir(folder_name:String):
	var err = dir.open("user://"+folder_name)
	if err == OK:
		print("already exists")
	else:
		err = dir.open("user://")
		if err != OK:
			print(str( err) )
		err = dir.make_dir(folder_name)
		if err != OK:
			print(str( err) )

