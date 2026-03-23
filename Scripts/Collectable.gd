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
@export var spawnable : PackedScene
@export var icon : Texture2D

var count : int


func _to_string() -> String:
	return "{0} : <{1} {2}> (active : {3})".format([name, rarity, type, active])
