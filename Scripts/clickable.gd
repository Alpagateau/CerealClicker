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

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("LeftClick"):
		if hovered:
			clicked.emit()

func _on_mouse_entered() -> void:
	hovered = true
	hover_on.emit()

func _on_mouse_exited() -> void:
	hovered = false
	hover_off.emit()
