extends Control


var iventory:Iventory

export var g_wumpa:NodePath
export var g_life:NodePath
export var g_crate:NodePath

var t_wumpa:Label
var t_life:Label
var t_crate:Label

func _ready():
	add_to_group("gameplay_ready")

func _gameplay_ready():
	if !character_exists():
		return
	t_wumpa = get_node(g_wumpa)
	t_life = get_node(g_life)
	t_crate = get_node(g_crate)
	
	iventory.connect("wumpa_added",self,"_on_wumpa_added")
	iventory.connect("crate_added",self,"_on_crate_added")
	iventory.connect("life_added",self,"_on_life_added")
	
	visible = true
		
func character_exists() -> bool:
	if get_tree().get_nodes_in_group("player").size() > 0:
		iventory = get_tree().get_nodes_in_group("player")[0].iventory
		print("iventory got")
		return true
	printerr("AT IVENTORY GUI: CHARACTER NOT FOUND")
	return false
	
func _on_wumpa_added(amt):
	t_wumpa.text = str(amt)
	pass
	
func _on_crate_added(amt):
	t_crate.text = str(amt)
	pass
	
func _on_life_added(amt):
	t_life.text = str(amt)
	pass
