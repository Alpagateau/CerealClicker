@icon("res://icons/trophy.svg")
extends Resource
class_name Collectable

@export_group("Properties")
@export var rarity : Constants.Rarity
@export var type : Constants.CollectableType
@export var name : String
@export_multiline var descr : String
@export var tags : Array[String]
@export var active : bool = true
@export_group("Scenes")
@export_subgroup("Legacy")
@export var spawnable : PackedScene
@export_subgroup("Defautl")
@export var model : PackedScene
@export var shader : ShaderMaterial
@export var texture : Texture2D
@export var position : Vector3
@export var rotation : Vector3
@export var scale    : Vector3


var count : int

func _to_string() -> String:
	return "{0} : <{1} {2}> (active : {3})".format([name, rarity, type, active])
