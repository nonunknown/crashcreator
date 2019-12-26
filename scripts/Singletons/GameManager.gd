extends Node



enum {GAMEMODE_EDIT,GAMEMODE_PLAY}

var varGAMEMODE = GAMEMODE_EDIT

func GAMEMODE_SET(GAMEMODE):
	pass
	
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
	

