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
		$MarginContainer/VBoxContainer/HBoxContainer/Label.visible = v
		count = count+1 if v else 0
		$MarginContainer/VBoxContainer/HBoxContainer/Label.text = str(count)
		unlocked = v

@export var count : int = 0

func update_size() -> void:
	pass

func _on_screen_change_size() -> void:
	pass

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick") and unlocked:
		clicked.emit(obj)
