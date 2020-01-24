extends Spatial

onready var tween:Tween = $Tween
export var duration:float
var target_pos:Node
var aku_pos:Node
var aku_head_pos:Node
var invincible:bool = false
export var material_pena_n:Texture
export var material_pena_g:Texture

var player
func set_player(p):
	player = p

func _ready():
	aku_pos = player.get_node("AkuPos")
	aku_head_pos = get_tree().get_nodes_in_group("aku_head")[0]
	set_process(false)
	
func _process(delta):
#	var pos = target_pos.global_transform.origin
	var rot = aku_pos.get_parent().rotation.y
	if invincible:
		self.translation = aku_head_pos.global_transform.origin
		self.rotation.y = rot
	else:
		self.translation = lerp(self.translation,aku_pos.global_transform.origin,.03)
		self.rotation.y = lerp(self.rotation.y,rot,0.01)
		
		
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
		4:
			play_invicibility()
			target_pos = aku_head_pos
			$AnimationPlayer.play("null")
			invincible = true
			player.twist_crash.enable_spin(true)
			pass
		2:		
			target_pos = aku_pos
			$AnimationPlayer.play("Move")
		3:
			target_pos = aku_pos
			$AnimationPlayer.play("Move")
			to_gold()
			pass
			
func _on_char_health_decreased(health):
	match health:
		3:
			$AnimationPlayer.play("Move")
			invincible = false
			player.twist_crash.enable_spin(false)
			pass
		2:
				
			pass
		1:
			self.visible = false
			set_process(false)
	if (health > 1):
		$sfx_lose.play()

func play_invicibility():
	$ost_invincibility.play()
	yield(get_tree().create_timer($ost_invincibility.stream.get_length()-1.3,false),"timeout")
	player.health_decrease()
