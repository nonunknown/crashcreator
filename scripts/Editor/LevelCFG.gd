extends Node
class_name LevelCFG
var logger:Logger
var _regex:RegEx
func _init(logg:Logger=null):
	if logg != null:
		self.logger = logg
	_regex = RegEx.new()
	_regex.compile("^[a-zA-Z0-9_]*$")



static func get_dictionary() ->Dictionary:
	return {title="",url=""}

func generate_level_cfg(dict:Dictionary):
	if not _is_valid(dict): return
	var config:ConfigFile = ConfigFile.new()
	config.set_value("data","title",dict.title)
	config.set_value("data","url",dict.url)
	var err = config.save(FileManager.user_dir.custom_level+"/"+FileManager.editingLevel.filename+".cfg")

func _is_valid(dict:Dictionary) -> bool:
	
	var array = [dict.title,dict.url]
	
	for text in array:
		if text == "":
			logger.logg("Error: text must not be empty")
			return false
#		var r = _regex.search(text)
#		if not r.is_valid():
#			logger.logg("Error: text is only alphanumeric")
#			return false
	
	return true
