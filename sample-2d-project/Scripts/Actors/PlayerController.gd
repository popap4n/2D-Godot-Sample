class_name PlayerController extends Node3D

@export var ForwardWalkSpeed : float	= 1.0
@export var BackWalkSpeed : float		= 1.0

var _event_manager	: EventManager
var _animator		: AnimatedSprite3D
var _move_vector		: Vector2

func OnMove(new_value : Vector2) -> void:
	_move_vector = new_value

func GetMoveVector() -> Vector2:
	return _move_vector

func InjectAnimator(new_animator : AnimatedSprite3D) -> void:
	_animator = new_animator

func _physics_process(delta : float) -> void:
	
	var move_axis : float = _move_vector.x
	
	var speed : float
	
	if (move_axis > 0.0):
		if (_animator and _animator.animation != "Walk Forward"):
			_animator.play("Walk Forward")
		speed = ForwardWalkSpeed
	elif (move_axis < 0.0):
		if (_animator and _animator.animation != "Walk Back"):
			_animator.play("Walk Back")
		speed = BackWalkSpeed
	elif (_animator and _animator.animation != "Idle"):
		_animator.play("Idle")
		
	var translate_vector = speed * Vector3(move_axis, 0.0, 0.0) * delta
	translate(translate_vector)

func _ready() -> void:
	_event_manager = Singleton.Get(EventManager)
	_event_manager.OnMoveEvent.connect(OnMove)
