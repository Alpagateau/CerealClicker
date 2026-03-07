extends Node3D
class_name Inventory

var inv : Array[String] = []

func add(c : Collectable):
	if c.name not in inv:
		inv += [c.name]
		inv.sort()

func get_owned(c : Collectable) -> bool:
	return c.name in inv
