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

func _on_player_died():
	pass
	
func _on_attacked():
	emit_signal("health_decreased")
	pass
