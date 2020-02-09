extends Crate
class_name CrateTNT
export var use_jp_material:bool = false
export var jp_texture:Texture
# Called when the node enters the scene tree for the first time.

func _ready():
	pass

#var last_value = false
#func _process(delta):
#	if Engine.editor_hint:
#		if (use_jp_material != last_value):
#			if (use_jp_material):
#				get_node("base_crate/model_crate/Cube").set_surface_material(0,jp_material)
#			else:
#				get_node("base_crate/model_crate/Cube").set_surface_material(0,material)
#			last_value = use_jp_material
#
#
#
#
#	else:
#		pass

func _on_Jumped():
#	Destroy()
	$Area/CollisionShape.disabled = true
	$sfx_activate.play()
	$AnimationPlayer.play("activate")
	yield(get_tree().create_timer(3.52,false),"timeout")
	Explosion.new(get_parent(),translation)
#	visible = false	
	Destroy()
#	yield(get_tree().create_timer($sfx.stream.get_length()-3.52,false),"timeout")
#	queue_free()

func Destroy(change_visibility:bool=true):
	print("destroying: "+name)
	$Area/CollisionShape.disabled= true
	if ($AreaBottom != null): $AreaBottom/CollisionShape.disabled = true
	$CollisionShape.disabled = true
	$model.visible = !change_visibility
	destroyed = true
	print("destroyed: "+name)
	
func revive():
	.revive()
	$AnimationPlayer.play("idle")
	$Area/CollisionShape.disabled = false
	
	visible = true

func _on_Exploded():
	visible = false
#	Explosion.new(get_parent(),self.global_transform.origin)
#	queue_free()
	pass





func _on_Area_area_entered(_area):
	pass # Replace with function body.
