@icon("res://icons/clickable.svg")
extends Area3D
class_name Clickable

signal hover_on
signal hover_off
signal clicked

var hovered : bool = false

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)

func _on_mouse_entered() -> void:
	hovered = true
	hover_on.emit()

func _on_mouse_exited() -> void:
	hovered = false
	hover_off.emit()

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed("LeftClick"):
		clicked.emit()
