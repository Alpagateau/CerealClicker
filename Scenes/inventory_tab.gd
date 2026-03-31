extends Control
class_name InventoryTab

@export var inv : Inventory
@export var database : Collector
@export var default_icon : PackedScene
@export var tp : trinket_preview

@export var custom_tab : CustomTabView

var opened : bool = false

func _ready() -> void:
	custom_tab.inv = inv 
	custom_tab.database = database 
	custom_tab.default_icon = default_icon 
	custom_tab.tp = tp
	if opened:
		open()
	else:
		close()
	custom_tab.setup_ready()
	

func open():
	#$MarginContainer.visible = true
	$MarginContainer/SubViewportContainer.visible = true
	$Button.text = '<'
	SignalBus.inventory_open.emit()

func close():
	#$MarginContainer.visible = false
	$MarginContainer/SubViewportContainer.visible = false
	$Button.text = '>'
	tp.visible = false
	SignalBus.inventory_close.emit()

func _on_button_pressed() -> void:
	opened = !opened 
	if opened:
		open()
	else:
		close()
