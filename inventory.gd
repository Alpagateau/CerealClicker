extends Node3D
class_name Inventory

var inv : Dictionary

@export var tk_preview : trinket_preview
@export var tk_grd : InventoryTab

func _ready() -> void:
	var saved : = SaveManager.save_data.inventory
	for k in saved.keys():
		add(k, false)
	SignalBus.day_start.connect(reset_inv)
func _input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_S):
		SaveManager.save_data.inventory = inv
		SaveManager.save_game()
		print("Saved")

func reset_inv():
	inv = {}

func add(c : Collectable, show_preview : bool = true):
	inv[c] = 1 if (c not in inv.keys()) else inv[c] + 1
	tk_grd.custom_tab.unlock(c)
	if show_preview:
		tk_preview.visible = true
		tk_preview.clicks_to_quit = 2
		tk_preview.trinket = c
		tk_preview.update_trinket()

func get_owned(c : Collectable) -> bool:
	return c.name in inv
