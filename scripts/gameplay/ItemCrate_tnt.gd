extends "res://scripts/gameplay/ItemCrate.gd"

export var use_jp_material:bool = false
export var jp_texture:Texture
onready var anim = get_node("base_crate/model_crate/AnimationPlayer")
# Called when the node enters the scene tree for the first time.

func _ready():
	pass

#var last_value = false
#func _process(delta):
#	if Engine.editor_hint:
#		if (use_jp_material != last_value):
#			if (use_jp_material):
#				get_node("base_crate/model_crate/Cube").set_surface_material(0,jp_material)
#			else:
#				get_node("base_crate/model_crate/Cube").set_surface_material(0,material)
#			last_value = use_jp_material
#
#
#
#
#	else:
#		pass

func _on_Jumped():
	$Area/CollisionShape.disabled = true
	$sfx.play()
	$AnimationPlayer.play("activate")
	yield(get_tree().create_timer(3.52,false),"timeout")
	Explosion.new(get_parent(),self.global_transform.origin)
	visible = false	
	yield(get_tree().create_timer($sfx.stream.get_length()-3.52,false),"timeout")
	queue_free()

func _on_Exploded():
	visible = false
	Explosion.new(get_parent(),self.global_transform.origin)
	queue_free()
	pass



