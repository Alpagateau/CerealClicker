extends Control
class_name TrinketIcon

@export var texture : Texture2D : 
	set(t):
		$TextureRect.texture = t
		texture = t
@export var unlocked : bool : 
	set(v):
		$BoxContainer/CheckBox.button_pressed = v
		unlocked = v
@export var percentage : float = 50

func update_size() -> void:
	pass

func _on_screen_change_size() -> void:
	pass
