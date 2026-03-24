extends Control
class_name EndDayUI

var combinations : Array[TrinketCombination]
@export_dir var combination_file
@export var inv : Inventory
@export var label : PackedScene

var scores : Array

func _ready() -> void:
	get_all_combination()
	print(combinations)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		visible = true
		print(calc_score())
		animate_screen()
	if $NextScore.is_stopped() && $NextText.is_stopped() && scores == []:
		visible = false

func animate_screen():
	scores = calc_score()
	for c in $PanelContainer/VBoxContainer/HBoxContainer/CombNames.get_children():
		$PanelContainer/VBoxContainer/HBoxContainer/CombNames.remove_child(c)
		c.queue_free()
	for c in $PanelContainer/VBoxContainer/HBoxContainer/ComScores.get_children():
		$PanelContainer/VBoxContainer/HBoxContainer/ComScores.remove_child(c)
		c.queue_free()
	draw_next_name()

func draw_next_name():
	if scores == []:
		return
	var new_label : Label = label.instantiate()
	new_label.text = scores[-1][0]
	$PanelContainer/VBoxContainer/HBoxContainer/CombNames.add_child(new_label)
	#scores.pop_back()
	$NextText.start()
	$NextScore.start()

func draw_next_score():
	if scores == []:
		return
	var new_label : Label = label.instantiate()
	new_label.text = str(scores[-1][1])
	scores.pop_back()
	$PanelContainer/VBoxContainer/HBoxContainer/ComScores.add_child(new_label)


func calc_score() -> Array:
	var score : Array = []
	for c in combinations:
		var valid : bool = true
		for tv in c.needed:
			print("Processing ", tv.trinket)
			if tv.trinket not in inv.inv.keys():
				print(tv.trinket, inv.inv.keys())
				valid = false 
				break
			elif inv.inv[tv.trinket] < tv.num:
				print(inv.inv[tv.trinket], tv.num)
				valid = false
				break
		if valid:
			score += [[c.name, c.value]]
	return score

func get_all_combination():
	var dir = DirAccess.open(combination_file)
	if !dir:
		return 
	dir.list_dir_begin()
	var file_name = dir.get_next()
	combinations = []
	while file_name != "":
		# Do somethin
		var full = dir.get_current_dir(true) + "/"+ file_name
		if ResourceLoader.exists(full):
			var res = ResourceLoader.load(full)
			if res is TrinketCombination:
				var c : TrinketCombination = res
				combinations += [c]
				print("> Loaded Combination ", c.name)
		file_name = dir.get_next()


func _on_day_cycle_day_end() -> void:
	animate_screen()
	pass # Replace with function body.
