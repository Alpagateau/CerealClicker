extends Node3D
class_name Box

signal box_empty
signal eating

@export var capacity : int = 90
var filling : int
@export var can_eat : bool
@export var bitesize : int = 16
@export var empty_box : PackedScene
@export var box_animator : AnimationPlayer

func _ready() -> void:
	filling = capacity

func throw_box() -> void:
	var thrown_box : RigidBody3D = empty_box.instantiate()
	add_sibling(thrown_box)
	thrown_box.global_position = $MeshInstance3D2.global_position
	thrown_box.global_rotation = $MeshInstance3D2.global_rotation
	
	var side_multiplier : float = (1 if randf() > 0.5 else -1) * randf()
	thrown_box.apply_impulse(Vector3(-5, 3 + randf() * 0.8, (-3  + randf()*0.7) * side_multiplier ) )
	box_animator.play("Open")
	
func _on_clickable_clicked() -> void:
	if filling > 0:
		filling -= bitesize
		if filling <= 0:
			throw_box()
			filling = capacity
			box_empty.emit()
		else:
			eating.emit()
