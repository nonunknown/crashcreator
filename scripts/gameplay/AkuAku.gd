extends Spatial

onready var tween:Tween = $Tween
export var duration:float
var target_pos:Vector3
var aku_pos:Node

export var material_pena_n:Texture
export var material_pena_g:Texture

func _ready():
	aku_pos = get_tree().get_nodes_in_group("player")[0].get_node("AkuPos")
	set_process(false)
func _process(delta):
	target_pos = aku_pos.global_transform.origin
	var target_rot = aku_pos.get_parent().rotation.y
	self.translation = lerp(self.translation,target_pos,.03)
	self.rotation.y = lerp(self.rotation.y,target_rot,0.01)
#	tween.interpolate_property(self,"translation",self.translation,target_pos,duration,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
#	tween.start()

func to_gold():
	var mat:Node = $Armature/Skeleton/AkuAku
	mat.set("material/1/albedo_texture",material_pena_g)
	$light.visible = true

func _on_char_health_increased(health):
	if (health > 1):
		self.visible = true
		set_process(true)

	match health:
		3:
			to_gold()
		2:
			pass
func _on_char_health_decreased(health):
	match health:
		3:
			pass
		2:
				
			pass
		1:
			self.visible = false
			set_process(false)
	if (health > 0):
		$sfx_lose.play()
	
	
	
	
		
