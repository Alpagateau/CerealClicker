extends Node3D
class_name Inventory

var inv : Array[Collectable] = []

func add(c : Collectable):
	if c not in inv:
		inv += [c]

func get_owned(c : Collectable) -> bool:
	return c.name in inv
