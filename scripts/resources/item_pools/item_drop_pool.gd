class_name ItemDropPool
extends Resource

@export var categories: Array[ItemCategory]
@export var tag_weights: Dictionary = {}

func get_scenes_by_categories(name: String) -> Array[PackedScene]:
	for cat in categories:
		if cat.category_name == name:
			return cat.scenes
	return []
