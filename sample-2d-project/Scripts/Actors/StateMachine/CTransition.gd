class_name CTransition
extends Transition

func _init(new_state: State, new_condition: Predicate) -> void:
	target_state = new_state
	condition = new_condition
