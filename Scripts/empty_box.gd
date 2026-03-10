extends RigidBody3D

func _on_static_timer_timeout() -> void:
	freeze = true
	lock_rotation = true
	print("turned static")
