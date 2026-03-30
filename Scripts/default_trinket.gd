extends Node3D
class_name DefaultTrinket

@export var trinket : Collectable

func _ready():
	if trinket == null:
		return
	
	#Old trinket way (for compatibility sake)
	if trinket.spawnable != null:
		var c : Node3D = trinket.spawnable.instantiate()
		add_child(c)
		return
		
	var m : Node3D = trinket.model.instantiate()
	m.position = trinket.position
	m.rotation_degrees = trinket.rotation
	m.scale = trinket.scale
	for c in m.get_children():
		if c is MeshInstance3D:
			c.material_override = trinket.shader.duplicate(true)
			c.material_override.set("shader_parameter/texture_albedo", trinket.texture)
			c.material_override.set("albedo_texture", trinket.texture)
	add_child(m)
			
