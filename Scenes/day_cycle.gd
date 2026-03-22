extends Node3D
class_name day_cycle

signal day_end
signal day_begin

func start_day():
	$Timer.start()
	day_begin.emit()



func _on_timer_timeout() -> void:
	day_end.emit()
	pass # Replace with function body.
