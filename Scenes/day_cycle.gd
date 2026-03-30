extends Node3D
class_name day_cycle

signal day_end
signal day_begin

@export var auto_start : bool = true

func _ready() -> void:
	if auto_start:
		start_day()

func start_day():
	$Timer.start()
	day_begin.emit()

func _on_timer_timeout() -> void:
	print("That's the end")
	day_end.emit()
