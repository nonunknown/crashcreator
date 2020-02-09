class_name Power

enum {DOUBLE_JUMP}
var list = {}

func add(_power_id:int):
	list[DOUBLE_JUMP] = DoubleJump.new()
	pass

class ThePower:
	func start():
		print("implement power")
		
	func update():
		pass

class DoubleJump extends ThePower:
	func get_jumps() -> int: return 2
	
