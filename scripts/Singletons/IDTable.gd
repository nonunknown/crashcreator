extends Node

var crates:Dictionary = {
	-1: null,
	0: load("res://gameplay/crates/obj_crate_simple.tscn"),
	5: load("res://gameplay/crates/obj_crate_bounce.tscn"),
	8: load("res://gameplay/crates/obj_crate_tnt.tscn"),
	9: load("res://gameplay/crates/obj_crate_nitro.tscn")
}
