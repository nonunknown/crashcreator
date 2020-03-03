extends Control
class_name MenuManager

var menus:Array

func start():
	Utils.make_transition(Utils.EFFECT.FADE_OUT,.7)
	for menu in menus:
		menu.start()
		Utils.make_transition(Utils.EFFECT.FADE_OUT,1)
		
		if (menu.wait_for_input):
			yield(menu.is_done(),"done")
		else:
			yield(get_tree().create_timer(menu.wait_time,true),"timeout")
		
		Utils.make_transition(Utils.EFFECT.FADE_IN,1)
		yield(get_tree().create_timer(1,true),"timeout")
		menu.finish()
		
	pass
	
func add_menu(menu:Menu):
	menus.append(menu)
	
func _ready():
	start()
