extends Node3D
class_name Collector

const ALL_COLLECTABLES = [
preload("res://Collectables/card_banditkeeper.tres"),
preload("res://Collectables/card_beekeeper.tres"),
preload("res://Collectables/card_gambelus.tres"),
preload("res://Collectables/card_janus.tres"),
preload("res://Collectables/card_moonkeeper.tres"),
preload("res://Collectables/card_prota.tres"),
preload("res://Collectables/card_sunkeeper.tres"),
preload("res://Collectables/card_zany.tres"),
preload("res://Collectables/keychain_banditmask.tres"),
preload("res://Collectables/keychain_bluecap.tres"),
preload("res://Collectables/keychain_caddy.tres"),
preload("res://Collectables/keychain_coolcap.tres"),
preload("res://Collectables/keychain_dice.tres"),
preload("res://Collectables/keychain_dolphin.tres"),
preload("res://Collectables/keychain_fedora.tres"),
preload("res://Collectables/keychain_greencap.tres"),
preload("res://Collectables/keychain_key.tres"),
preload("res://Collectables/keychain_leek.tres"),
preload("res://Collectables/keychain_moonmask.tres"),
preload("res://Collectables/keychain_orangehorse.tres"),
preload("res://Collectables/keychain_pinkhorse.tres"),
preload("res://Collectables/keychain_redcap.tres"),
preload("res://Collectables/keychain_shatteredmaskb.tres"),
preload("res://Collectables/keychain_shatteredmaskm.tres"),
preload("res://Collectables/keychain_shatteredmasks.tres"),
preload("res://Collectables/keychain_springonion.tres"),
preload("res://Collectables/keychain_sunmask.tres"),
preload("res://Collectables/oofball_argentina.tres"),
preload("res://Collectables/oofball_brazil.tres"),
preload("res://Collectables/oofball_cyan.tres"),
preload("res://Collectables/oofball_dev.tres"),
preload("res://Collectables/oofball_england.tres"),
preload("res://Collectables/oofball_france.tres"),
preload("res://Collectables/oofball_germany.tres"),
preload("res://Collectables/oofball_godot.tres"),
preload("res://Collectables/oofball_golden.tres"),
preload("res://Collectables/oofball_italy.tres"),
preload("res://Collectables/oofball_mango.tres"),
preload("res://Collectables/oofball_spain.tres"),
preload("res://Collectables/oofball_uruguay.tres"),
preload("res://Collectables/oofball_yinyang.tres"),
preload("res://Collectables/oofball_yinyangred.tres"),
preload("res://Collectables/plush_bunny.tres"),
preload("res://Collectables/rat1.tres"),
preload("res://Collectables/rat2.tres"),
preload("res://Collectables/skate_default.tres"),
preload("res://Collectables/skate_flames.tres"),
preload("res://Collectables/skate_mcfly.tres"),
preload("res://Collectables/skate_mountaindew.tres")

]

@export var RarityWeight : Array[int] = [
	4,
	3,
	2,
	1
]
var total_weight : int = 10

const collectables_directory = "res://Collectables/"

var collectables : Dictionary

func _ready() -> void:
	total_weight = 0
	for i in RarityWeight:
		total_weight += i
	get_all_collectables()
	#print_rarity(Constants.Rarity.COMMON)
	#print_rarity(Constants.Rarity.UNCOMMON)
	#print_rarity(Constants.Rarity.RARE)
	#print_rarity(Constants.Rarity.LEGENDARY)

func print_rarity(r : Constants.Rarity):
	if r in collectables.keys():
		print(collectables[r])
	else:
		print("[Empty]")

func get_all_collectables():
	collectables[0] = []
	collectables[1] = []
	collectables[2] = []
	collectables[3] = []
	for res in ALL_COLLECTABLES:
		if res is Collectable:
			var c : Collectable = res
			if c.active:
				print("> Loaded ", c.name)
				if c.rarity in collectables.keys():
					collectables[c.rarity] += [c]
				else:
					collectables[c.rarity] = [c]
	(collectables[0] as Array).sort_custom(func(a, b): return a.file_name.naturalnocasecmp_to(b.file_name) < 0)
	(collectables[1] as Array).sort_custom(func(a, b): return a.file_name.naturalnocasecmp_to(b.file_name) < 0)
	(collectables[2] as Array).sort_custom(func(a, b): return a.file_name.naturalnocasecmp_to(b.file_name) < 0)
	(collectables[3] as Array).sort_custom(func(a, b): return a.file_name.naturalnocasecmp_to(b.file_name) < 0)

func random_draw() -> Collectable:
	var rarity : Constants.Rarity = choose_rarity()
	var c : Collectable = choose(collectables[rarity])
	while (c == null):
		rarity = choose_rarity()
		c = choose(collectables[rarity])
	return c

## Returns a random element in the given array
func choose(arr : Array):
	if len(arr) == 0:
		return null
	var i : int = floor(len(arr) * randf())
	return arr[i]

func choose_rarity() -> Constants.Rarity:
	var r : float = randf()
	var ra : Constants.Rarity = Constants.Rarity.LEGENDARY
	var off : float = 0
	for i in range(len(RarityWeight) - 1):
		if  r - off < (float(RarityWeight[i]) / float(total_weight)):
			ra = i as Constants.Rarity
			break
		off += (float(RarityWeight[i]) / float(total_weight))
	return ra

func _on_box_box_empty() -> void:
	var c : Collectable = random_draw()
	$"../Inventory".add(c)
	pass # Replace with function body.
