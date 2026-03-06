@icon("res://icons/clickable.svg")
extends Area3D
class_name Clickable

signal hover_on
signal hover_off
signal clicked

var hovered : bool = false

func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if hovered:
			clicked.emit()

func _on_mouse_entered() -> void:
	hovered = true
	hover_on.emit()

func _on_mouse_exited() -> void:
	hovered = false
	hover_off.emit()
