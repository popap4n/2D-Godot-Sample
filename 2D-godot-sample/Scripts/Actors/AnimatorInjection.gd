class_name AnimatorInjection
extends AnimatedSprite3D

@export var _controller: PlayerController

func _ready() -> void:
	if _controller:
		_controller.inject_animator(self)
