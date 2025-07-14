extends Node
class_name ItemManager

signal item_box_ready(box: Control)

@onready var names = ["Ashbrand", "Stormfang", "Whisperfang", "Oathkeeper", "Runeblade", "Very Long sword Of Naming Test Purposes"]
@onready var reqs = ["Strength", "Dexterity", "Intelligence", "Spirit"]
@onready var stats = ["+%d Fire Damage", "+%d Attack Speed", "+%d Life Leech", "+%d Mana Regen"]
@onready var item_box_scene: PackedScene = preload("res://scenes/ui/item_box.tscn")

var current_item_box: Node = null

func generate_item_box() -> void:
	if current_item_box:
		current_item_box.queue_free()
		current_item_box = null
	
	var new_box := item_box_scene.instantiate()
	current_item_box = new_box
	new_box.set_item(generate_item_data())
	
	
	emit_signal("item_box_ready", new_box)

func generate_item_data() -> ItemData:
	var item = ItemData.new()
	item.name = get_random_from_list(names)
	
	var req_config = StatBlockConfig.new()
	req_config.source = reqs
	req_config.amount = 2
	req_config.min_val = 10
	req_config.max_val = 30
	req_config.format = "%s: %d"
	item.requirements = _generate_lines(req_config)
	
	var stat_config = StatBlockConfig.new()
	stat_config.source = stats
	stat_config.amount = randi_range(1, 6)
	stat_config.min_val = 1
	stat_config.max_val = 30
	stat_config.format = "%s"
	item.statistics = _generate_lines(stat_config)
	
	return item



func _generate_lines(config: StatBlockConfig) -> Array:
	var selected = get_multiple_random_from_list(config.source, config.amount)
	var lines: Array = []
	for entry in selected:
		var value = randi_range(config.min_val, config.max_val)

		# If the format includes %s and %d, use both entry and value
		if config.format.count("%") >= 2:
			lines.append(config.format % [entry, value])

		# If the entry itself is the format string (like "+%d Fire Damage")
		elif entry.find("%d") != -1:
			lines.append(entry % value)

		# Fallback: assume format wants just entry
		else:
			lines.append(config.format % entry)

	return lines



func get_random_from_list(list: Array) -> String:
	if list.size() > 0:
		return list[randi_range(0, list.size() - 1)]
	return ""

func get_multiple_random_from_list(source_list: Array, amount: int) -> Array:
	var pool = source_list.duplicate()
	pool.shuffle()
	return pool.slice(0, amount)
