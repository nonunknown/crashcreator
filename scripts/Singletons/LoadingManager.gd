extends Node

onready var loading = load("res://scenes/scn_Loading.tscn").instance()
var custom_root = null

func _ready():
	custom_root = Node.new()
	custom_root.name = "CustomRoot"
	custom_root.owner = get_tree().root
	get_tree().root.call_deferred("add_child",custom_root)
#	Utils.reparent(get_tree().root.get_child(get_tree().root.get_child_count()-2),custom_root)
	get_tree().root.call_deferred("add_child",loading)
	var transition = load("res://Fader/Transition.tscn").instance()
	get_tree().root.call_deferred("add_child",transition)
	Utils.transition = transition
	Utils.make_transition(Utils.EFFECT.CLEAN,1)
	var root = get_tree().root
	var node = root.get_child(root.get_child_count()-1)
	print(node.name)
	yield(get_tree(),"idle_frame")
	Utils.reparent(node,custom_root)
#	Utils.reparent(get_tree().root.get_child(get_tree().root.get_child_count()-1),custom_root)
	
#	Utils.make_transition(Utils.EFFECT.BLACK,1)
var new_scene = null
func load_level(level:String):
	yield( _load_it() ,"completed")
	yield( load_scene(level),"completed")
	_load_new_scene()
	pass


func set_start_scene(scene:Node):
	Utils.reparent(scene,custom_root)

func load_scene(level):
	GameManager.change_scene_async(level,{})
	yield(GameManager,"done")
	pass

func _load_new_scene():
	Utils.make_transition(Utils.EFFECT.FADE_IN,1)
	yield(get_tree().create_timer(1,false),"timeout")
	yield(get_tree(),"idle_frame")
	loading.disable()
	custom_root.call_deferred("add_child",GameManager.loaded_scene)
	clear_custom_root()
	Utils.make_transition(Utils.EFFECT.FADE_OUT,1)
	pass

func clear_custom_root():
	for child in custom_root.get_children():
		child.call_deferred("queue_free")

func _load_it():
	Utils.make_transition(Utils.EFFECT.FADE_IN,1)
	yield(get_tree().create_timer(1,false),"timeout")
	clear_custom_root()
	if get_tree().get_nodes_in_group("loading") != null:
		custom_root.call_deferred("add_child",loading)
	yield(get_tree(),"idle_frame")
	loading.enable()
	
	Utils.make_transition(Utils.EFFECT.FADE_OUT,1)
#	yield(get_tree().create_timer(1,false),"timeout")

