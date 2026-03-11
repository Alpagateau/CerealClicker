extends Control
class_name TrinketIcon

@export var obj : PackedScene : 
	set(t):
		var cs = $SubViewportContainer/SubViewport/Root.get_children()
		for c in cs:
			c.queue_free()
		if t != null:
			var nt = t.instantiate()
			$SubViewportContainer/SubViewport/Root.add_child(nt)
		obj = t
@export var unlocked : bool : 
	set(v):
		$BoxContainer/CheckBox.button_pressed = v
		unlocked = v
@export var percentage : float = 50

func update_size() -> void:
	pass

func _on_screen_change_size() -> void:
	pass
