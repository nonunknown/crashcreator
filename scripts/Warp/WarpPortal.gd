extends Particles
class_name WarpPortal

export var texture:Texture
export var curve_in:Curve
export var curve_out:Curve
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var portals
var opened = false
func _ready():
	emit(false)
	set_texture(texture)
	set_process(false)
	portals = get_node("../../Portals")
	pass

func set_texture(tex:Texture):
	draw_pass_1.surface_get_material(0).albedo_texture = tex


func emit(activate:bool):
	emitting = activate
	visible = activate
	if activate:
		lifetime = 600
	else: lifetime = 0
	
	
# Called when the node enters the scene tree for the first time.
func expand():
	emit(true)
	if (portals != null):
		portals.disable()
	opened = true
	get_node("../Area/CollisionShape").disabled = false
	interpolate(curve_in)
	$portal_expand.play()
	yield(get_tree().create_timer(.2,false),"timeout")
	$portal_loop.play()
	$rays.visible = true
	pass # Replace with function body.

func contract(without_effects=false):
	if without_effects == false:
		interpolate(curve_out)
		$portal_contract.play()
	else:
		print("disabling portal")
		emit(false)

	$portal_loop.stop()
	opened = false
	get_node("../Area/CollisionShape").disabled = true	
	$rays.visible = false

func interpolate(_curve:Curve):
	offset = 0
	curve = _curve
	set_process(true)
	
		
var curve = null
var offset = 0

func _process(delta):
	process_material.set("scale",curve.interpolate(offset))
	offset += delta
	if (offset >= .99): set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
