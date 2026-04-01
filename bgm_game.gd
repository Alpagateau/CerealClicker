extends AudioStreamPlayer

func _ready() -> void:
	SignalBus.day_start.connect(turn_on)
	SignalBus.day_end.connect(turn_off)

func turn_on():
	var twine : Tween = create_tween()
	twine.tween_property(self, "volume_db", -18, 0.6)
	twine.set_ease(Tween.EASE_OUT)
	twine.set_trans(Tween.TRANS_CUBIC)
	
func turn_off():
	var twine : Tween = create_tween()
	twine.tween_property(self, "volume_db", -80, 0.6)
	twine.set_ease(Tween.EASE_OUT)
	twine.set_trans(Tween.TRANS_CUBIC)
