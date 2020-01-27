extends TextEdit
class_name Logger

var parent = null

func _ready():
	add_keyword_color("Warning",Color.yellow)
	add_keyword_color("Error",Color.red)
	add_keyword_color("ERROR",Color.red)
	add_keyword_color("Success",Color.green)
	add_keyword_color("Editing",Color.blue)
	add_keyword_color("Selected",Color.aqua)
	parent = get_parent()

func logg(_text:String) -> void:
	if parent.visible == false:
		parent.visible = true
		reset = true
		time = 3
	text += "\n"+_text
	

var time = 0
var reset = false
func _process(delta):
	if not reset: return
	if time > 0:
		time -= delta
	else:
		time = 0
		reset = false
		parent.visible = false
