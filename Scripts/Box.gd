extends Node3D
class_name Box

signal box_empty

@export var capacity : int = 70
var filling : int
@export var bitesize : int = 16

func _ready() -> void:
	filling = capacity

func _on_clickable_clicked() -> void:
	print("Miam")
	if filling > 0:
		filling -= bitesize
		if filling <= 0:
			print("DODAD")
			filling = capacity
			box_empty.emit()
