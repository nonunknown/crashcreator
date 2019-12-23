extends "res://scripts/gameplay/ItemCrate.gd"

export var use_jp_material:bool
export var jp_material:SpatialMaterial
export var material_3:SpatialMaterial
export var material_2:SpatialMaterial
export var material_1:SpatialMaterial

onready var anim = get_node("base_crate/model_crate/AnimationPlayer")
# Called when the node enters the scene tree for the first time.
func _ready():
	if use_jp_material:
		get_node("base_crate/model_crate/Cube").set_surface_material(0,jp_material)

func _on_Jumped():
	anim.play("anim_item_tnt_activate")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Exploded():
	Explosion.new(get_parent())
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
	pass # Replace with function body.


func _on_Area_area_entered(area):
	$base_crate/Area.queue_free() #disable collision detection
