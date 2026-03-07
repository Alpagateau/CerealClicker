extends Node3D

@export var RarityWeight : Array[int] = [
	4,
	3,
	2,
	1
]
var total_weight : int = 10

@export_dir var collectables_directory 

var collectables : Dictionary

func _ready() -> void:
	total_weight = 0
	for i in RarityWeight:
		total_weight += i
	get_all_collectables()
	print_rarity(Constants.Rarity.COMMON)
	print_rarity(Constants.Rarity.UNCOMMON)
	print_rarity(Constants.Rarity.RARE)
	print_rarity(Constants.Rarity.LEGENDARY)
	
func print_rarity(r : Constants.Rarity):
	if r in collectables.keys():
		print(collectables[r])
	else:
		print("[Empty]")

func get_all_collectables():
	var dir = DirAccess.open(collectables_directory)
	if !dir:
		return 
	dir.list_dir_begin()
	var file_name = dir.get_next()
	collectables[0] = []
	collectables[1] = []
	collectables[2] = []
	collectables[3] = []
	while file_name != "":
		# Do somethin
		var full = dir.get_current_dir(true) + "/"+ file_name
		if ResourceLoader.exists(full):
			var res = ResourceLoader.load(full)
			if res is Collectable:
				var c : Collectable = res
				if c.active:
					print("> Loaded ", c.name)
					if c.rarity in collectables.keys():
						collectables[c.rarity] += [c]
					else:
						collectables[c.rarity] = [c]
		file_name = dir.get_next()

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
	print(random_draw())
	pass # Replace with function body.
