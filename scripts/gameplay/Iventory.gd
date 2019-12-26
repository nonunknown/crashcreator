extends Node
class_name Iventory

var life:int = 0
var wumpa:int = 0
var crates:int = 0



func check(target:int) -> int:
	if (target >= 100):
		target = target-100
		
	return target

func add_life(amt:int):
	life += amt
	life = check(life)
		
func add_wumpa(amt:int):
	wumpa+= amt
	wumpa = check(wumpa)
func add_crate(amt:int):
	crates += amt
	crates = check(crates)
