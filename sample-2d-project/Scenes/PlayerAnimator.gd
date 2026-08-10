class_name PlayerAnimator extends AnimatedSprite3D

@export var controller : PlayerController

func _enter_tree() -> void:
	controller.InjectAnimator(self)
