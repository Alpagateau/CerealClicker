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
