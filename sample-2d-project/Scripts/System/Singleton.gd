class_name Singleton

# classes that want singleton functionality call these functions
# to store and access one specific instance separately for each type

static func TrySet(instance : Node) -> void:
	
	if (!instance):
		return
	
	var type : Variant				= instance.get_script()
	var current_reference : Node	= Get(type)
	
	# if instance for specified class is empty, store this reference
	if (!current_reference):
		_instance_map[type] = instance
	# otherwise if the instance stored internally isn't equal
	# to the one specified, delete that specified instance
	elif (current_reference != instance):
		instance.queue_free()

static func Get(type : Variant) -> Node:
	return _instance_map.get(type)

# dictionary for mapping each class to one instance
static var _instance_map : Dictionary[Variant, Node] = {}
