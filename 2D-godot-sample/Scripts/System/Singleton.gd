class_name Singleton

static func try_set(new_instance: Node) -> void:
	var class_type: Variant		= new_instance.get_script()
	var current_instance: Node	= get_instance(class_type)
	
	if !current_instance:
		_instance_map[class_type] = new_instance
	elif new_instance != current_instance:
		new_instance.queue_free()

static func get_instance(class_type: Variant) -> Node:
	return _instance_map.get(class_type)

static var _instance_map: Dictionary[Variant, Node] = {}
