extends Node

var selected_single = null
var selected_multi = []

signal _selection_changed


func update_single_selection(s):
    emit_signal("_selection_changed")
    selected_single = s