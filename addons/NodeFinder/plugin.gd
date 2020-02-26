tool
extends EditorPlugin

var node_name = "NodeFinder"
func _enter_tree():
    add_autoload_singleton( node_name , "res://addons/NodeFinder/NodeFinder.gd")
    pass

func _exit_tree():
    remove_autoload_singleton( node_name )
    pass