class_name IdleState
extends PlayerState


func on_enter() -> void:
	_animator.play("Idle")


func on_update(_delta: float) -> void:
	return


func on_exit() -> void:
	return


func _init(new_controller: PlayerController, new_animator: AnimatedSprite3D) -> void:
	_controller = new_controller
	_animator = new_animator
