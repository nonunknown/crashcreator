extends Node

var levels:Dictionary = {
	editor = "res://scenes/scn_LevelEditor.tscn",
	warp_room = "res://scenes/scn_Room.tscn",
	intro = "res://Menu/Intro.tscn"
}

var crates:Dictionary = {
	-1: null,
	0: load("res://gameplay/crates/obj_crate_simple.tscn"),
	1: load("res://gameplay/crates/obj_crate_question.tscn"),
	2: load("res://gameplay/crates/obj_crate_checkpoint.tscn"),
	3: load("res://gameplay/crates/obj_crate_wood_jump.tscn"),
	4: load("res://gameplay/crates/obj_crate_enforced.tscn"),
	5: load("res://gameplay/crates/obj_crate_bounce.tscn"),
	6: load("res://gameplay/crates/obj_crate_aku.tscn"),
	7: load("res://gameplay/crates/obj_crate_life.tscn"),
	8: load("res://gameplay/crates/obj_crate_tnt.tscn"),
	9: load("res://gameplay/crates/obj_crate_nitro.tscn"),
	10: load("res://gameplay/crates/obj_crate_time.tscn")
}
var crates_texture:Dictionary = {
	-1: null,
	0: load("res://textures/gameplay/boxes-crate-top.png"),
	1: load("res://textures/gameplay/boxes-crate-side.png"),
	2: load("res://textures/gameplay/boxes-checkpoint-crate.png"),
	3: load("res://textures/gameplay/boxes-crate-jump.png"),
	4: load("res://textures/gameplay/boxes-enforced.png"),
	5: load("res://textures/gameplay/boxes-wumpa.png"),
	6: load("res://textures/gameplay/boxes-aku.png"),
	7: load("res://textures/gameplay/boxes-life.png"),
	8: load("res://textures/gameplay/boxes-tnt-side.png"),
	9: load("res://textures/gameplay/boxes-nitro-side.png"),
	10: load("res://textures/gameplay/boxes-time-top.png"),
}
var items:Dictionary = {
	0: load("res://gameplay/obj_item_clock.tscn"),
	1: load("res://gameplay/obj_item_aku.tscn")
}

var character = load("res://gameplay/obj_Character.tscn")

var entities:Dictionary = {
	0: character,
	1: load("res://gameplay/warp/obj_warp_portal.tscn"),
	2: items[0]
}

var material_crate_time:Dictionary = {
	0: load("res://textures/gameplay/materials/mat_time_zero.material"),
	1: load("res://textures/gameplay/materials/mat_time_one.material"),
	2: load("res://textures/gameplay/materials/mat_time_two.material"),
	3: load("res://textures/gameplay/materials/mat_time_three.material")
}

var timeable_crates:Array = [0,1,2,3,4,5,7]

func is_timeable(id) -> bool:
	for _id in timeable_crates:
		if (_id == id):
			return true
	return false

func get_mat_from_tex_id(id:int) -> SpatialMaterial:
	var mat = SpatialMaterial.new()
	mat.set_texture(SpatialMaterial.TEXTURE_ALBEDO,crates_texture[id])
	return mat
