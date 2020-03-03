extends Spatial

export var linked_portal:NodePath = ""

var machine_manager:Utils.MachineManager
var _portal:WarpPortal = null
enum {EMERGE,SUBMERGE,RELEASED,PRESSED,INACTIVE,IDLE}
func _ready():
	print(str(linked_portal))
	if linked_portal != "":
		_portal = get_node(linked_portal)
	else:
		disable()
		return
	machine_manager = Utils.MachineManager.new()
	machine_manager.register_state_array(self,[EMERGE, 
	SUBMERGE,RELEASED,PRESSED,INACTIVE,IDLE
	], ["emerge",
	"submerge","released","pressed", "inactive","idle"
	])
	machine_manager.change_state(SUBMERGE)
	
	

func st_init_emerge():
	$Anim.play("emerge")
	yield(get_tree().create_timer(.5,false),"timeout")
	pass
func st_update_emerge():
	
	pass
func st_exit_emerge():
	pass
	
func st_init_submerge():
	$Anim.play("submerge")
	
	pass
func st_update_submerge():
	pass
func st_exit_submerge():
	pass
	
func st_init_released():
	$Anim.play("released")
	pass
func st_update_released():
	pass
func st_exit_released():
	pass
	
func st_init_pressed():
	$Anim.play("pressed")
	if _portal != null and _portal.opened == false:
		_portal.expand()
	pass
func st_update_pressed():
	pass
func st_exit_pressed():
	pass
	
func st_init_inactive():
	$Anim.play("inactive")
	pass
func st_update_inactive():
	pass
func st_exit_inactive():
	pass
	
func st_init_idle():
	$Anim.play("idle")
	
	pass
func st_update_idle():
	pass
func st_exit_idle():
	pass

func disable():
	$Area/CollisionShape.disabled = true
	visible = false



func _on_Area_area_entered(area):
	if Utils.is_player(area): machine_manager.change_state(PRESSED)
	pass # Replace with function body.


func _on_Area_area_exited(area):
	if Utils.is_player(area): machine_manager.change_state(RELEASED)
	pass # Replace with function body.


func _on_Anim_animation_finished(anim_name):
	match anim_name:
		"submerge":
			machine_manager.change_state(INACTIVE)
		"emerge":
			machine_manager.change_state(IDLE)
	pass # Replace with function body.
