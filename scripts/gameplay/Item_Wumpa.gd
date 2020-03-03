extends Item
class_name ItemWumpa

func _player_picked(player:Character):
	print("picked")
	if (player == null): return
	player.iventory.add_wumpa(1)
#	self.visible = false
	effect_got()
	pass # Replace with function body.

var i = 1
func effect_got():
	set_process(true)
	yield(get_tree().create_timer(.5,false),"timeout")
	i = 0
	yield(get_tree().create_timer(.5,false),"timeout")
	self.visible = false
#	var t = $Tween as Tween
#	t.interpolate_property($Sprite,"translation",$Sprite.translation,Utils.get_player().get_global_transform().origin,1,Tween.TRANS_QUINT,Tween.EASE_IN_OUT)
#	t.start()

func _process(delta):
	var targets = [Utils.get_player().get_global_transform().origin + Vector3.UP,Utils.get_player().get_global_transform().origin + Vector3.UP + Vector3.LEFT * 5]
	translation = lerp(translation,targets[i],.05)

func _on_Area_area_entered(area):
	if picked: return
	print("area of wumpa")
	print("area: "+str(area.collision_layer))
	print(str(area))


func play_idle():
	$AnimationPlayer.play("indle",1)
	$AnimationPlayer.advance(rand_range(0,$AnimationPlayer.current_animation_length))
