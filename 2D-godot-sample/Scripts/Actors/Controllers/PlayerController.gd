class_name PlayerController
extends Node3D

@export var forward_walk_speed: float	= 1.0
@export var backward_walk_speed: float	= 1.0

var _event_manager:	EventManager
var _state_machine:	StateMachine
var _idle_state:	IdleState
var _move_state:	MoveState
var _animator:		AnimatedSprite3D

@onready var _input_vector := Vector2.ZERO

#region Lifecycle Methods
func _physics_process(delta: float) -> void:
	_state_machine.update(delta)


func _ready() -> void:
	_event_manager = Singleton.get_instance(EventManager)
	_event_manager.move_invoked.connect(set_input_vector)
	
	_idle_state = IdleState.new(self, _animator)
	_move_state = MoveState.new(self, _animator)
	_state_machine = StateMachine.new(_idle_state)
	
	at(_idle_state, _move_state, FuncPredicate.new(func() -> bool: return is_moving()))
	at(_move_state, _idle_state, FuncPredicate.new(func() -> bool: return !is_moving()))


func _enter_tree() -> void:
	return
#endregion

func at(previous_state: State, next_state: State, condition: Predicate) -> void:
	_state_machine.add_transition(previous_state, next_state, condition)


func is_moving() -> bool:
	return _input_vector != Vector2.ZERO


func set_input_vector(new_input_vector: Vector2) -> void:
	_input_vector = new_input_vector


func get_input_vector() -> Vector2:
	return _input_vector


func handle_movement(delta: float) -> void:
	var move_vector := Vector3(_input_vector.x, 0.0, 0.0)
	var speed: float = 0
	
	if _input_vector.x > 0.0:
		speed = forward_walk_speed
	elif _input_vector.x < 0.0:
		speed = backward_walk_speed
	
	var translate_vector: Vector3 = speed * move_vector * delta
	translate(translate_vector)


func inject_animator(new_animator: AnimatedSprite3D) -> void:
	_animator = new_animator
