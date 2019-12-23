extends Spatial

onready var tween:Tween = $Tween
export var duration:float
var target_pos:Vector3
var aku_pos:Node
func _ready():
	aku_pos = get_tree().get_nodes_in_group("player")[0].get_node("AkuPos")
	print(aku_pos.translation)
	print(aku_pos.global_transform.origin)
func _process(delta):
	target_pos = aku_pos.global_transform.origin
	tween.interpolate_property(self,"translation",self.translation,target_pos,duration,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
	tween.start()
