extends "res://scripts/gameplay/ItemCrate.gd"

export var use_jp_material:bool
export var jp_material:SpatialMaterial
export var material_3:SpatialMaterial
export var material_2:SpatialMaterial
export var material_1:SpatialMaterial


# Called when the node enters the scene tree for the first time.
func _ready():
	if use_jp_material:
		get_node("base_crate/model_crate/Cube").set_surface_material(0,jp_material)
	pass # Replace with function body.

func _on_Jumped():
	get_node("base_crate/AnimationPlayer").play("anim_item_tnt_activate")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
