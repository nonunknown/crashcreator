extends Node

var dir = "user://custom/test.level"

func save_level(data):
    var save_game = File.new()
    save_game.open(dir, File.WRITE)
    save_game.store_line(to_json(data))
    save_game.close()
    print("saved")

func save_path():
	var pathList = get_tree().get_nodes_in_group("gp_path")
	
	var pathDataArray = {}
	var i:int = 0
	for path in pathList:
		var data = {
			"mName": reg(path.name,"@([^)]+)@"),
			"posX": path.translation.x,
			"posY": path.translation.y,
			"posZ": path.translation.z
		}
		pathDataArray[i] = data
		i += 1
	print(pathDataArray)
	save_level(pathDataArray)
	
func reg(word,pattern):
	var regex = RegEx.new()
	regex.compile(pattern)
	var result = regex.search(word)
	if result:
    	return result.get_string().replace("@","")
	else: return word
