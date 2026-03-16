
extends Control
class_name trinket_preview

@export var trinket : Collectable
var vis : Node3D = null


func update_trinket() -> void:
	if vis != null:
		vis.queue_free()
	if trinket != null:
		vis = trinket.spawnable.instantiate()
		$CenterContainer2/SubViewportContainer/SubViewport.add_child(vis)
		$CenterContainer/VBoxContainer/ItemName.text = trinket.name
		$CenterContainer/VBoxContainer2/DescriptionLabel.text = trinket.descr
		$CenterContainer/VBoxContainer/RarityLabel.text = Constants.rarity2str(trinket.rarity)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		visible = false

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick"):
		visible = false
	pass # Replace with function body.
