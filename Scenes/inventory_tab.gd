extends Control
class_name InventoryTab

@export var inv : Inventory
@export var database : Collector
@export var default_icon : PackedScene

var opened : bool = false

@onready var grids : Array[Control] = [
	$MarginContainer/TabContainer/Common/CenterContainer/GridContainer,
	$MarginContainer/TabContainer/Uncommon/CenterContainer/GridContainer,
	$MarginContainer/TabContainer/Rare/CenterContainer/GridContainer,
	$MarginContainer/TabContainer/Legendary/CenterContainer/GridContainer
]

func _ready() -> void:
	#Read inventory
	var keys = database.collectables.keys()
	for k in keys:
		for c in database.collectables[k]:
			var new_icon : TrinketIcon = default_icon.instantiate() as TrinketIcon
			new_icon.texture = (c as Collectable).icon
			grids[k].add_child(new_icon)
			pass
	
	if opened:
		open()
	else:
		close()
	

func open():
	$MarginContainer.visible = true
	$Button.text = '<'

func close():
	$MarginContainer.visible = false
	$Button.text = '>'
	
func _on_button_pressed() -> void:
	opened = !opened 
	if opened:
		open()
	else:
		close()
