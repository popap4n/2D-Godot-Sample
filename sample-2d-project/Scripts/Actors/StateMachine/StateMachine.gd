class_name StateMachine

var _current_node: StateNode
var _nodes: Dictionary[Variant, StateNode]


func update(delta: float) -> void:
	var transition: Transition  = _get_transition()
	if transition:
		_change_state(transition.target_state)
	_current_node.state.on_update(delta)


func set_state(new_state: State) ->  void:
	var new_node: StateNode = _try_get(new_state)
	_current_node = new_node
	_current_node.state.on_enter()


func get_state() -> State:
	return _current_node.state


func _init(new_state: State) -> void:
	set_state(new_state)


func add_transition(previous_state: State, next_state: State, condition: Predicate) -> void:
	_try_get(previous_state).add_transition(_try_get(next_state).state, condition)


func _change_state(new_state: State) -> void:
	if new_state == _current_node.state:
		return
	var previous_state: State = _current_node.state
	var next_state: State = _nodes[new_state.get_script()].state
	
	previous_state.on_exit()
	next_state.on_enter()
	_current_node = _nodes[new_state.get_script()]


func _get_transition() -> Transition:
	for transition: Transition in _current_node.transitions:
		if transition.condition.evaluate():
			return transition
	return null


func _try_get(state: State) -> StateNode:
	var node: StateNode = _nodes.get(state.get_script())
	if !node:
		node = StateNode.new(state)
		_nodes[state.get_script()] = node
	return node


class StateNode:
	var state: State
	var transitions: Dictionary[Transition, bool]
	
	func _init(new_state: State) -> void:
		state = new_state
		transitions = {}
	
	func add_transition(target_state: State, condition: Predicate) -> void:
		var new_transition := CTransition.new(target_state, condition)
		transitions[new_transition as Transition] = true
