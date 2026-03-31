extends Node3D
class_name day_cycle

signal day_end
signal day_begin

@export var auto_start : bool = true

func _ready() -> void:
	SignalBus.inventory_open.connect(pause_timer)
	SignalBus.inventory_close.connect(unpause_timer)
	SignalBus.day_start.connect(start_day)
	if auto_start:
			SignalBus.day_start.emit()

func pause_timer():
	$Timer.paused = true

func unpause_timer():
	$Timer.paused = false

func start_day():
	$Timer.start()
	print("[Day Start]")
	day_begin.emit()


func _on_timer_timeout() -> void:
	print("[Day End]")
	day_end.emit()
	SignalBus.day_end.emit()
