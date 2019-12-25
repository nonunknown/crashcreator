extends Spatial

onready var tween:Tween = $Tween
export var duration:float
var target_pos:Vector3
var aku_pos:Node

export var material_pena_n:Texture
export var material_pena_g:Texture

func _ready():
	aku_pos = get_tree().get_nodes_in_group("player")[0].get_node("AkuPos")
	print(aku_pos.translation)
	print(aku_pos.global_transform.origin)
func _process(delta):
	target_pos = aku_pos.global_transform.originBR

	tween.interpolate_property(self,"translation",self.translation,target_pos,duration,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
	tween.start()

func kill():
	#play lose sound
	#yield when sound finish
	queue_free()


func to_gold():
	var mat:Node = $Armature/Skeleton/AkuAku
	mat.set("material/1/albedo_texture",material_pena_g)
	$light.visible = true

func _on_char_health_increased(health):
	self.visible = true

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
	
	$sfx_lose.play()
		
