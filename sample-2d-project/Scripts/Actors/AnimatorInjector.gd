class_name AnimatorInjector extends AnimatedSprite3D

@export var _controller : PlayerController

func _enter_tree() -> void:
	if (_controller):
		_controller.InjectAnimator(self)
