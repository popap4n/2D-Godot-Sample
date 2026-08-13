class_name EventManager
extends Node

signal move_invoked(input_vector: Vector2)

@onready var _input_vector: Vector2 = Vector2.ZERO

func _input(_event: InputEvent) -> void:
	var move_axis: float = Input.get_axis("Walk Back", "Walk Forward")
	var new_input_vector := Vector2(move_axis, 0.0)
	
	if new_input_vector != _input_vector:
		_input_vector = new_input_vector
		move_invoked.emit(_input_vector)

func _enter_tree() -> void:
	Singleton.try_set(self)
