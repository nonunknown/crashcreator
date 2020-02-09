extends KinematicCharacter
class_name Enemy

var event_gameplay:GameplayEvent

func _ready():
	event_gameplay = GameplayEvent.new(self)

func _process(delta):
	_update(delta)

func on_Attacked():
	print("implement enemy on attack")

func _update(_delta):
	pass

func _on_game_restart():
	print("implement on game restart")
