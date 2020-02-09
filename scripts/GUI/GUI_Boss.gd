extends Control

onready var health_bar = $Control.get_children()
onready var temp_health = health_bar
export var health_amt = 1
export var update:bool = false
onready var event:GameplayEvent = GameplayEvent.new(self)

func _process(delta):
	if update:
		update = false



func _on_game_restart():
	print("reset health bar")
	temp_health = health_bar
	for bar in $Control.get_children():
		print(bar.name)
		bar.visible = true


func _on_boss_health_decreased():
	print("attacked")
	health_bar[temp_health.size()-1].visible  = false
	temp_health.remove(temp_health.size()-1)
	pass # Replace with function body.
