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
	$Open.visible = false
	$Close.visible = true
	$SwooshIn.play()
	SignalBus.inventory_open.emit()

func close():
	#$MarginContainer.visible = false
	$MarginContainer/SubViewportContainer.visible = false
	$Close.visible = false
	$Open.visible = true
	tp.visible = false
	$SwooshOut.play()
	SignalBus.inventory_close.emit()

func _on_button_pressed() -> void:
	opened = !opened 
	if opened:
		open()
	else:
		close()

func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("LeftClick"):
		_on_button_pressed()
	pass # Replace with function body.
