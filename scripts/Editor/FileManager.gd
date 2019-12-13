extends Node

signal s_generate_area

var dir = "user://level.json"
var level_data = {
	paths = {},
	models = [],
	crates = {},
	character = {},
	config = {}
}

func save_level(data):
    level_data.paths = data
    var save_game = File.new()
    save_game.open(dir, File.WRITE)
    save_game.store_line(to_json(level_data))
    save_game.close()
    print("saved")

func save_path():
	var pathList = get_tree().get_nodes_in_group("gp_path")
	
	var pathDataArray = {}
	var i:int = 0
	for path in pathList:
		var model_name = reg(path.name,"@([^)]+)@")
		file_insert_model_name(model_name)
		var data = {
			"mName": model_name,
			"posX": path.translation.x,
			"posY": path.translation.y,
			"posZ": path.translation.z
		}
		pathDataArray[i] = data
		i += 1
	print(pathDataArray)
	print(level_data)
	save_level(pathDataArray)

func load_level():
	clear_actual_level()
	var save_game = File.new()
	if not save_game.file_exists(dir):
		print("no save-file found!")
		pass
	save_game.open(dir, File.READ)
	while not save_game.eof_reached():
		var data = parse_json(save_game.get_line())
		if data == null: pass
		else: 
			var n = get_node("/root/Main/Level/Path")
			n.generate_area(data.paths)
		
	save_game.close()

func clear_actual_level():
	var level = get_tree().get_nodes_in_group("gp_level")[0].get_children()
	for child in level:
		var c = child.get_children()
		for i in c:
			i.queue_free()
			
func reg(word,pattern):
	var regex = RegEx.new()
	regex.compile(pattern)
	var result = regex.search(word)
	if result:
    	return result.get_string().replace("@","")
	else: return word

func file_insert_model_name(name):
	for i in range(level_data.models.size()):
		if (level_data.models[i] == name):
			return
	level_data.models.append(name)
			
	pass


