extends Node2D
class_name CustomTabView

signal tab_changed(idx : int)

var current_tab : int = 0
@export var tabs : Array[Sprite2D] 

@export var inv : Inventory
@export var database : Collector
@export var default_icon : PackedScene
@export var tp : trinket_preview

@export var grids : Array[Control] = []

@export var icon_bg : Array[Texture2D]

func setup_ready() -> void:
	#Read inventory
	var keys = database.collectables.keys()
	for k in keys:
		for c in database.collectables[k]:
			var new_icon : TrinketIcon = default_icon.instantiate() as TrinketIcon
			new_icon.obj = c
			new_icon.clicked.connect(show_preview)
			(new_icon.get_child(0).get_child(0) as TextureRect).texture = icon_bg[k]
			grids[k].add_child(new_icon)

func update_current_tab(idx : int):
	tabs[current_tab].visible = false 
	current_tab = idx 
	tabs[current_tab].visible = true

func show_preview(trinket : Collectable):
	tp.trinket = trinket
	tp.update_trinket()
	tp.visible = true
	pass

func unlock(c : Collectable):
	var grd : GridContainer = grids[c.rarity]
	for ch in grd.get_children():
		if ch is TrinketIcon:
			ch = ch as TrinketIcon
			if ch.obj == c:
				ch.unlocked = true

func _on_common_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("LeftClick"):
		update_current_tab(0)
		tab_changed.emit(0)

func _on_uncommon_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("LeftClick"):
		update_current_tab(1)
		tab_changed.emit(1)

func _on_rare_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("LeftClick"):
		update_current_tab(2)
		tab_changed.emit(2)
