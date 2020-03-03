extends GuiToolsBase


onready var path_manager = get_node("../../Level/Path")
var bt_model_path:String = "TabContainer/Built-in/VBoxContainer/GridContainer/"

export var tool_id:int
export var bt_base_model:PackedScene

func _init():
	_ID = Utils.EDITOR_STATE.PATH
	
func _ready():
	path_manager.connect("generate_path_buttons",self,"_on_generate_path_buttons")
	
func _on_generate_path_buttons(path_loaded):
	for path in path_loaded:
		var bt_model = bt_base_model.instance()
		get_node(bt_model_path).add_child(bt_model)
		bt_model.text = path.instance().show_name
	pass


func toggle_bt_add(toggle):
	$Panel/VBoxContainer/bt_add.disabled = toggle;
	

