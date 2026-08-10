class_name EventManager extends Node

signal OnMoveEvent(move_vector : Vector2)

func _input(_event : InputEvent) -> void:
	var move_axis : float		= Input.get_axis("Walk Back", "Walk Forward")
	var move_vector : Vector2	= Vector2(move_axis, 0.0)
	OnMoveEvent.emit(move_vector)

func _enter_tree() -> void:
	Singleton.TrySet(self)
