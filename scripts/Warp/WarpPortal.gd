extends Spatial
class_name WarpPortal

export var id:int = -1
export var linked_level_info:NodePath = ""
export var texture:Texture
export var curve_in:Curve
export var curve_out:Curve
onready var portal:Particles = $portal
onready var collision:CollisionShape = $Area/CollisionShape
onready var sounds:Dictionary = {
	loop = $portal/portal_loop,
	expand = $portal/portal_expand,
	contract = $portal/portal_contract
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var portals
var opened = false
var _level_info:LevelInfo = null

func _ready():
	emit(false)
	set_texture(texture)
	set_process(false)
	portals = get_node("../Portals")
	if linked_level_info != "":
		_level_info = get_node(linked_level_info) as LevelInfo
		_level_info.config("Level Editor!")
	pass

func set_texture(tex:Texture):
	portal.draw_pass_1.surface_get_material(0).albedo_texture = tex


func emit(activate:bool):
	portal.emitting = activate
	visible = activate
	if activate:
		portal.lifetime = 600
	else: portal.lifetime = 1
	
	
# Called when the node enters the scene tree for the first time.
func expand():
	emit(true)
	_level_info.show()
	if (portals != null):
		portals.disable()
	opened = true
	collision.disabled = false
	interpolate(curve_in)
	sounds.expand.play()
	yield(get_tree().create_timer(.2,false),"timeout")
	sounds.loop.play()
	$portal/rays.visible = true
	pass # Replace with function body.

func contract(without_effects=false):
	_level_info.hide()
	if without_effects == false:
		interpolate(curve_out)
		sounds.contract.play()
	else:
		print("disabling portal")
		emit(false)

	sounds.loop.stop()
	opened = false
	collision.disabled = true	
	$portal/rays.visible = false

func interpolate(_curve:Curve):
	offset = 0
	curve = _curve
	set_process(true)
	
		
var curve = null
var offset = 0

func _process(delta):
	portal.process_material.set("scale",curve.interpolate(offset))
	offset += delta
	if (offset >= .99): set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
