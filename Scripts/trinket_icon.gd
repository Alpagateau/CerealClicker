extends Control
class_name TrinketIcon

signal clicked(r : Collectable)

@export var obj : Collectable : 
	set(t):
		var cs = $SubViewportContainer/SubViewport/Root.get_children()
		for c in cs:
			c.queue_free()
		if t != null:
			var nt = t.spawnable.instantiate()
			$SubViewportContainer/SubViewport/Root.add_child(nt)
		obj = t
@export var unlocked : bool : 
	set(v):
		$SubViewportContainer.material.set("shader_parameter/hidden", !v)
		unlocked = v
@export var percentage : float = 50



func update_size() -> void:
	pass

func _on_screen_change_size() -> void:
	pass

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick") and unlocked:
		clicked.emit(obj)
