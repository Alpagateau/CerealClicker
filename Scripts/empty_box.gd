extends RigidBody3D

func _ready():
	SignalBus.day_end.connect(queue_free)

func _on_static_timer_timeout() -> void:
	freeze = true
	lock_rotation = true
