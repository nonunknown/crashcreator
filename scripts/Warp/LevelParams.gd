extends Spatial
class_name LevelParams


static func get_config() -> Dictionary:
	var config:Dictionary = {
		ignore_first_player_enter = true,
		portal_id = -1
	}
	return config

func start_params(config:Dictionary):
	var portal_manager = get_tree().get_nodes_in_group("portal_manager")[0]
	var portal:WarpPortal = portal_manager.get_portal(config.portal_id)
	var player:Character = Utils.get_player()
	player.translation = portal.get_global_transform().origin + Vector3(0,4,0) + (portal.transform.basis.z* 2)
	yield(get_tree().create_timer(1,false),"timeout")
	portal.expand()
	portal.collision.disabled = true
	yield(get_tree().create_timer(.5,false),"timeout")
	player.do_jump()
	yield(get_tree().create_timer(.5,false),"timeout")
	
	player.velocity +=( portal.transform.basis.z * 125 ) 
	player.change_state(player.STATE.JUMP_MOVE)	
	yield(get_tree().create_timer(3,false),"timeout")
	portal.contract()
	pass

func _ready():
	pass

func _process(delta):
	if (Input.is_action_just_pressed("ui_accept")):
		start_params({portal_id=0})
