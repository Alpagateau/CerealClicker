extends Node

const save_path : String = "user://SaveFile.tres"

var save_data : SaveData = SaveData.new()

func _ready():
	#load_game()
	pass

func save_game():
	ResourceSaver.save(save_data, save_path)
	pass

func load_game():
	if FileAccess.file_exists(save_path):
		save_data = ResourceLoader.load(save_path).duplicate(true)
		print(save_data.inventory)
