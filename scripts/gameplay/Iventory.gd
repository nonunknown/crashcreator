extends Node
class_name Iventory

var life:int = 0
var wumpa:int = 0
var crates:int = 0

signal life_added
signal wumpa_added
signal crate_added

func add_life(amt:int):
	var _life = life + amt
	if (_life > 100): life = 100
	else: life = _life
	emit_signal("life_added",life)
	
func add_wumpa(amt:int):
	var _wumpa = wumpa+amt
	if (_wumpa >= 100): 
		wumpa = _wumpa - 100
		add_life(1)
	else: wumpa = _wumpa
	emit_signal("wumpa_added",wumpa)
	
func add_crate(amt:int):
	crates += amt
	emit_signal("crate_added",crates)
