class_name PlayerController
extends Node3D

@export var forward_walk_speed: float	= 1.0
@export var backward_walk_speed: float	= 1.0

var _event_manager:	EventManager
var _state_machine:	StateMachine
var _idle:			IdleState
var _move:			MoveState
var _crouch:		CrouchState
var _animator:		AnimatedSprite3D

@onready var _input_vector	:= Vector2.ZERO

#region Lifecycle Methods

func _ready() -> void:
	_event_manager = Singleton.get_instance(EventManager)
	if _event_manager:
		_event_manager.move_invoked.connect(set_input_vector)
	
	_idle = IdleState.new(self, _animator)
	_move = MoveState.new(self, _animator)
	_crouch = CrouchState.new(self, _animator)
	_state_machine = StateMachine.new(_idle)
	
	at(_idle, _move, FuncPredicate.new(func() -> bool: return is_moving() and !is_crouching()))
	at(_idle, _crouch, FuncPredicate.new(func() -> bool: return is_crouching()))
	
	at(_move, _idle, FuncPredicate.new(func() -> bool: return !is_moving() and !is_crouching()))
	at(_move, _crouch, FuncPredicate.new(func() -> bool: return is_crouching()))
	
	at(_crouch, _idle, FuncPredicate.new(func() -> bool: return !is_crouching() and !is_moving()))
	at(_crouch, _move, FuncPredicate.new(func() -> bool: return !is_crouching() and is_moving()))


func _physics_process(delta: float) -> void:
	_state_machine.update(delta)

#endregion
#region Public Methods

func handle_movement(delta: float) -> void:
	var move_vector := Vector3(_input_vector.x, 0.0, 0.0)
	var speed: float = 0
	
	if _input_vector.x > 0.0:
		speed = forward_walk_speed
	elif _input_vector.x < 0.0:
		speed = backward_walk_speed
	
	var translate_vector: Vector3 = speed * move_vector * delta
	translate(translate_vector)


func at(previous_state: State, next_state: State, condition: Predicate) -> void:
	_state_machine.add_transition(previous_state, next_state, condition)


func is_moving() -> bool:
	return _input_vector != Vector2.ZERO


func is_crouching() -> bool:
	print(_input_vector.y)
	return _input_vector.y < 0.0


func set_input_vector(new_input_vector: Vector2) -> void:
	_input_vector = new_input_vector


func get_input_vector() -> Vector2:
	return _input_vector


func inject_animator(new_animator: AnimatedSprite3D) -> void:
	_animator = new_animator

#endregion
