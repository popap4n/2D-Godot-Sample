class_name FuncPredicate
extends Predicate

var _function: Callable

func _init(new_function) -> void:
	_function = new_function

func evaluate() -> bool:
	return _function.call()
