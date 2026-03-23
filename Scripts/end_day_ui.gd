extends Control
class_name EndDayUI

var combinations : Array[TrinketCombination]
@export_dir var combination_file
@export var inv : Inventory

func _ready() -> void:
	get_all_combination()
	print(combinations)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		print(calc_score())

func calc_score() -> int:
	var score : int = 0
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
			score += c.value
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
