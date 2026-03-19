extends Node3D

@onready var anim_player : AnimationPlayer = $arms_rigged/AnimationPlayer
@export var box : Box
@export var in_hand : Node3D
@export var skeleton : Skeleton3D

func _ready() -> void:
	anim_player.speed_scale = 2
	box.box_empty.connect(_on_box_empty)
	box.eating.connect(_on_box_eating)
	_on_box_empty()

func _process(delta: float) -> void:
	var t : Transform3D = skeleton.get_bone_global_pose(
		skeleton.find_bone("Bone")
	)
	in_hand.global_position = skeleton.to_global(t.origin)
	in_hand.global_basis = t.basis
	pass

func _on_box_eating():
	anim_player.play("Eating")

func _on_box_empty():
	anim_player.play("Readying")
