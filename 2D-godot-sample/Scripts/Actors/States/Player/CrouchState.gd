class_name CrouchState
extends PlayerState

func on_enter() -> void:
	_animator.play("Crouch")
	print("Entered Crouch")

func on_update(_delta) -> void:
	return

func on_exit() -> void:
	return

func _init(new_controller: PlayerController, new_animator: AnimatedSprite3D) -> void:
	_controller = new_controller
	_animator = new_animator
