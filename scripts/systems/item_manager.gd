extends Node
class_name ItemManager

@onready var names = []
@onready var reqs = []
@onready var stats = []

func generate_item_data() -> ItemData:
	var item = ItemData.new()
	 
	return item
