extends TextEdit
class_name Logger

func _ready():
	add_keyword_color("Warning",Color.yellow)
	add_keyword_color("Error",Color.red)
	add_keyword_color("Success",Color.green)
	add_keyword_color("Editing",Color.blue)
	add_keyword_color("Selected",Color.aqua)

func logg(_text:String) -> void:
	text += "\n"+_text
