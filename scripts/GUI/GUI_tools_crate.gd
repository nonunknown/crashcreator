extends Control

#ID - 1

onready var editor_manager = get_node("/root/Main")

func _ready():
	editor_manager.connect("change_mode",self,"_on_mode_changed")
	pass
#	editor_manager.connect("on_")

func _on_mode_changed(_tool):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
