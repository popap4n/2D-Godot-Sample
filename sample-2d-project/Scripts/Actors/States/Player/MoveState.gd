class_name MoveState
extends PlayerState

var _input_vector := Vector2.ZERO


func on_enter() -> void:
	_input_vector = _controller.get_input_vector()
	if _input_vector.x > 0.0:
		_animator.play("Walk Forward")
	elif _input_vector.x < 0.0:
		_animator.play("Walk Back")


func on_update(delta: float) -> void:
	_controller.handle_movement(delta)
	
	_input_vector = _controller.get_input_vector()
	if _input_vector.x > 0.0:
		_animator.play("Walk Forward")
	elif _input_vector.x < 0.0:
		_animator.play("Walk Back")


func on_exit() -> void:
	return


func _init(new_controller: PlayerController, new_animator: AnimatedSprite3D) -> void:
	_controller = new_controller
	_animator = new_animator
