@tool
extends Control
class_name trinket_preview

@export var trinket : Collectable
var vis : Node3D = null

@export_tool_button("Update Trinket", "Callable") var ut_action : Callable = update_trinket

func update_trinket() -> void:
	if vis != null:
		vis.queue_free()
	if trinket != null:
		vis = trinket.spawnable.instantiate()
		$CenterContainer2/SubViewportContainer/SubViewport.add_child(vis)
