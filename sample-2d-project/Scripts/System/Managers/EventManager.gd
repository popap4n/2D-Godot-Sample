class_name EventManager
extends Node

signal move_invoked(move_vector: Vector2)

@onready var _move_vector: Vector2 = Vector2.ZERO

func _input(_event: InputEvent) -> void:
	var move_axis: float = Input.get_axis("Walk Back", "Walk Forward")
	var new_move_vector: Vector2 = Vector2(move_axis, 0.0)
	
	if new_move_vector != _move_vector:
		_move_vector = new_move_vector
		move_invoked.emit(_move_vector)

func _enter_tree() -> void:
	Singleton.try_set(self)
