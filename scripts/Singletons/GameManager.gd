extends Node



enum GAMEMODE {EDIT,PLAY}
enum EDITMODE {PATH,CRATE}
var GAME_MODE:int = GAMEMODE.EDIT

func GAMEMODE_SET(mode:int):
		GAME_MODE = mode

onready var scn:PackedScene = preload("res://scenes/scn_Gameplay.tscn")
func _ready():
	print(scn)
	
#	var s = PackedScene.new()
#
#	var n = Node.new()
#	var ss = Spatial.new()
#	n.add_child(ss)
#	ss.set_owner(n)
#	n.name = "ok"
#	var result = s.pack(n)
#	print(result)
#	if (result == OK):
#		ResourceSaver.save("res://custom_scenes/test.scn",s,64)
	

