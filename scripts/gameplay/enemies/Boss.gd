extends Enemy
class_name Boss

signal health_decreased

export var show_name:String
export var initial_health = 4

var character:Character
onready var health = initial_health

func _ready():
	character = Utils.get_player()
	character.connect("died",self,"_on_player_died")

func _on_game_restart():
	._on_game_restart()
	health = initial_health

func _on_player_died():
	pass

func _on_attacked():
	print("attacked boss")
	health -= 1
	emit_signal("health_decreased",health)
	pass
