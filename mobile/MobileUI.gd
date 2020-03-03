extends Node2D

onready var joystick_out = get_node("JoystickOut")
onready var joystick_in = get_node("JoystickOut/JoystickIn")
onready var btn_jump = get_node("ButtonJump")
onready var btn_attack = get_node("ButtonAttack")
onready var btn_dash = get_node("ButtonDash")

func _ready():
	ajust_button_location()
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	Input.action_release("ui_up")
	btn_jump.connect("pressed",self,"_jump_down")
	btn_jump.connect("released",self,"_jump_up")
	btn_attack.connect("pressed",self,"_attack_down")
	btn_attack.connect("released",self,"_attack_up")
	btn_dash.connect("pressed",self,"_dash_down")
	btn_dash.connect("released",self,"_dash_up")

func ajust_button_location():
	var screensize = get_viewport_rect().size
	joystick_out.global_position.x = 80
	joystick_out.global_position.y = screensize.y - 80
	btn_jump.global_position.x = screensize.x - 128
	btn_jump.global_position.y = screensize.y - 128
	btn_attack.global_position.x = screensize.x - 256
	btn_attack.global_position.y = screensize.y - 128
	btn_dash.global_position.x = screensize.x - 128
	btn_dash.global_position.y = screensize.y - 256

func get_joystick_value() -> Vector2:
	return joystick_in.get_value()

func _jump_down():
	Input.action_press("ui_jump")

func _jump_up():
	Input.action_release("ui_jump")

func _attack_down():
	Input.action_press("cmd_attack")

func _attack_up():
	Input.action_release("cmd_attack")

func _dash_down():
	Input.action_press("cmd_dash")

func _dash_up():
	Input.action_release("cmd_dash")
