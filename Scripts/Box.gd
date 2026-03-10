extends Node3D
class_name Box

signal box_empty

@export var capacity : int = 30
var filling : int
@export var bitesize : int = 16
@export var empty_box : PackedScene

func _ready() -> void:
	filling = capacity

func throw_box() -> void:
	var throw_box : RigidBody3D = empty_box.instantiate()
	add_sibling(throw_box)
	throw_box.global_position = $MeshInstance3D2.global_position
	throw_box.global_rotation = $MeshInstance3D2.global_rotation
	
	throw_box.apply_impulse(Vector3(-5, 3 + randf() * 0.8, -3  + randf()*0.7 ) )

func _on_clickable_clicked() -> void:
	print("Miam")
	if filling > 0:
		filling -= bitesize
		if filling <= 0:
			print("DODAD")
			throw_box()
			filling = capacity
			box_empty.emit()
