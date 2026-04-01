extends Control
class_name EndDayUI

var ALL_COMBINATION = [
]

var combinations : Array[TrinketCombination]
@export_dir var combination_file
@export var inv : Inventory
@export var label : PackedScene

@export var basic_str : String = "Your friends found your trinkets"
@export var opinions : Array[String] = [
	"Poopoo",
	"Okayish",
	"Funny",
	"Nice",
	"Cool",
	"Rad",
	"Dank",
	"Fun",
	"Great",
	"Increadible",
	"Amazing",
	"The Best Trinkets That Ever Lived"
]

var current_opinion = 0
var scores : Array

func _ready() -> void:
	get_all_combination()
	SignalBus.day_end.connect(_on_day_cycle_day_end)
	$PanelContainer/VBoxContainer/Friends.text = ""

func _process(_delta: float) -> void:
	if !$Friends.is_stopped():
		current_opinion = randi() % len(opinions)
		$PanelContainer/VBoxContainer/Friends.text = basic_str
		$PanelContainer/VBoxContainer/Friends2.text = opinions[current_opinion]
	if Input.is_action_just_pressed("Esc"):
		if $NextScore.is_stopped() && $NextText.is_stopped() && scores == [] && $Friends.is_stopped():
			visible = false

func animate_screen():
	scores = calc_score()
	for c in $PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/CombNames.get_children():
		$PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/CombNames.remove_child(c)
		c.queue_free()
	for c in $PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/ComScores.get_children():
		$PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/ComScores.remove_child(c)
		c.queue_free()
	draw_next_name()

func draw_next_name():
	if scores == []:
		draw_friends()
		return
	var new_label : Label = label.instantiate()
	new_label.text = scores[-1][0]
	$PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/CombNames.add_child(new_label)
	#scores.pop_back()
	$NextText.start()
	$NextScore.start()
	$Sound1.play()
	$Sound2.play()

func draw_friends():
	$Friends.start()
	$PanelContainer/VBoxContainer/Friends.visible = true
	$PanelContainer/VBoxContainer/Friends2.visible = true

func draw_next_score():
	if scores == []:
		return
	var new_label : Label = label.instantiate()
	new_label.text = str(scores[-1][1])
	scores.pop_back()
	$Sound1.play()
	$Sound2.play()
	$PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/ComScores.add_child(new_label)

func calc_score() -> Array:
	var score : Array = []
	var total : int = 0
	
	var common_counter : int = 0
	var uncommon_counter : int = 0
	var rare_counter : int = 0
	
	for k in inv.inv.keys():
		match (k as Collectable).rarity:
			Constants.Rarity.COMMON:
				common_counter += 1
			Constants.Rarity.UNCOMMON:
				uncommon_counter += 1
			Constants.Rarity.RARE:
				rare_counter += 1
	score += [
		["Rare Trinkets x " + str(rare_counter), rare_counter * 50],
		["Uncommon Trinkets x " + str(uncommon_counter), uncommon_counter * 25],
		["Common Trinkets x " + str(common_counter), common_counter * 10]
	]
	total += (rare_counter * 50) + (uncommon_counter * 25) + (common_counter * 10)
	for c in combinations:
		var valid : bool = true
		for tv in c.needed:
			if tv.trinket not in inv.inv.keys():
				valid = false 
				break
			elif inv.inv[tv.trinket] < tv.num:
				valid = false
				break
		if valid:
			score += [[c.name, c.value]]
			total += c.value
	score.push_front(["TOTAL", total])
	return score

func get_all_combination():
	combinations = []
	for res in ALL_COMBINATION:
		if res is TrinketCombination:
			var c : TrinketCombination = res
			combinations += [c]
			print("> Loaded Combination ", c.name)


func _on_day_cycle_day_end() -> void:
	visible = true
	$PanelContainer/VBoxContainer/Friends.visible = false
	$PanelContainer/VBoxContainer/Friends2.visible = false
	$PanelContainer/VBoxContainer/Click.visible = false
	animate_screen()
	pass # Replace with function body.


func _on_friends_timeout() -> void:
	$PanelContainer/VBoxContainer/Click.visible = true
	$Sound1.play()
	$Sound2.play()
	$Sound3.play(0.2)
	pass # Replace with function body.


func _on_gui_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("LeftClick"):
		if $PanelContainer/VBoxContainer/Click.visible:
			visible = false
			SignalBus.day_start.emit()
	pass # Replace with function body.
