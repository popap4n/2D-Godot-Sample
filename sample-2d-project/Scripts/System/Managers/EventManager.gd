class_name EventManager extends Node

signal OnMoveEvent(move_vector : Vector2)
var move_vector : Vector2

func _input(_event : InputEvent) -> void:
	var move_axis : float	= Input.get_axis("Walk Back", "Walk Forward")
	var new_move_vector		= Vector2(move_axis, 0.0)
	if (move_vector != new_move_vector):
		move_vector = new_move_vector
		OnMoveEvent.emit(move_vector)

func _enter_tree() -> void:
	Singleton.TrySet(self)
	move_vector = Vector2.ZERO
