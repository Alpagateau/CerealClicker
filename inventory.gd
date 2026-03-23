extends Node3D
class_name Inventory

var inv : Dictionary

@export var tk_preview : trinket_preview
@export var tk_grd : InventoryTab

func add(c : Collectable):
	tk_preview.visible = (c not in inv.keys())
	inv[c] = 1 if (c not in inv.keys()) else inv[c] + 1
	tk_preview.trinket = c
	tk_grd.custom_tab.unlock(c) # To Do
	tk_preview.clicks_to_quit = 2
	tk_preview.update_trinket()

func get_owned(c : Collectable) -> bool:
	return c.name in inv
