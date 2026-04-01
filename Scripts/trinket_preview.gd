
extends Control
class_name trinket_preview

@export var trinket : Collectable
var vis : Node3D = null
@export var clicks_to_quit : int = 1
var remaining_clicks : int = 0
var was_hidden : bool = true

func update_trinket() -> void:
	if vis != null:
		vis.queue_free()
		vis = null
	if trinket != null:
		vis = DefaultTrinket.new()
		vis.trinket = trinket
		$CenterContainer2/SubViewportContainer/SubViewport/Node3D.add_child(vis)
		$CenterContainer/VBoxContainer/ItemName.text = trinket.name
		$CenterContainer/VBoxContainer2/DescriptionLabel.text = trinket.descr
		$CenterContainer/VBoxContainer/RarityLabel.text = Constants.rarity2str(trinket.rarity)
		$AudioStreamPlayer.play(0.2)
		$AudioStreamPlayer2.play()

func _process(_delta: float) -> void:
	if was_hidden && visible:
		remaining_clicks = clicks_to_quit
	if Input.is_action_just_pressed("Esc"):
		visible = false
	was_hidden = not visible

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick"):
		remaining_clicks -= 1
		if remaining_clicks <= 0:
			visible = false
			clicks_to_quit = 1
	pass # Replace with function body.
