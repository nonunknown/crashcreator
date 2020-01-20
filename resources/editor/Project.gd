extends Resource
class_name Project

var path_models:Array = []

var crate_ids:Array = []
var crate_time_ids:Array = []
var crate_pos:PoolVector3Array = []

var entity_ids:Array = []
var entity_pos:PoolVector3Array = []

func pretty_print():
	print(to_dict())

func append_crate_pos(pos:Vector3):
	crate_pos.append(pos)

func append_entity_pos(pos:Vector3):
	entity_pos.append(pos)

func to_pool_vector3_dict(array:PoolVector3Array,dict:Dictionary, dict_pool_array:String):
	for vector in array:
		var x = str(vector.x)
		var y = str(vector.y)
		var z = str(vector.z)
		dict[dict_pool_array].xs.append(x)
		dict[dict_pool_array].ys.append(y)
		dict[dict_pool_array].zs.append(z)

func to_dict()-> Dictionary:
	var dict:Dictionary = {crate_pos={xs=[],ys=[],zs=[]},entity_pos={xs=[],ys=[],zs=[]}}
	dict["path_models"] = path_models
	
	dict["crate_ids"] = crate_ids
	dict["crate_time_ids"] = crate_time_ids
	
#	for pos in crate_pos:
#		var x = str(pos.x)
#		var y = str(pos.y)
#		var z = str(pos.z)
#		dict.crate_pos.xs.append(x)
#		dict.crate_pos.ys.append(y)
#		dict.crate_pos.zs.append(z)
#		pass

	to_pool_vector3_dict(crate_pos,dict,"crate_pos")
	dict["entity_ids"] = entity_ids
	to_pool_vector3_dict(entity_pos,dict,"entity_pos")
	return dict

func from_pool_vector3_dict(dict:Dictionary, dict_pool_array:String) -> PoolVector3Array:
	var pool:PoolVector3Array = []
	for i in dict[dict_pool_array].xs.size():
		pool.append(Vector3(
			dict[dict_pool_array].xs[i],
			dict[dict_pool_array].ys[i],
			dict[dict_pool_array].zs[i]
		))
	return pool

func from_dict(dict:Dictionary) -> void:
	path_models = dict.path_models
	crate_ids = dict.crate_ids
	crate_time_ids = dict.crate_time_ids
	crate_pos = from_pool_vector3_dict(dict,"crate_pos")
	entity_ids = dict.entity_ids
	entity_pos = from_pool_vector3_dict(dict,"entity_pos")
