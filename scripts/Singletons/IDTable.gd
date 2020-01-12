extends Node

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
			break
	return false


