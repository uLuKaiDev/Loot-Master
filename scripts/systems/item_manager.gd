class_name ItemManager
extends Node

signal item_box_ready(box: Control)

const RARITY_ORDER: Array = [
	"common",
	"uncommon",
	"rare",
	"epic",
	"unique"
]

@export var spawn_field_path: NodePath

var current_item_box: Node = null
var spawned_item_count: int = 0

@onready var names = ["Ashbrand", "Stormfang", "Whisperfang", "Oathkeeper", "Runeblade", "Deluxio"]
@onready var reqs = ["Strength", "Dexterity", "Intelligence", "Spirit"]
@onready var stats = [
	"+%d Fire Damage",
	"+%d Attack Speed",
	"+%d Life Leech",
	"+%d Mana Regen",
	"+%d Cold Resistance",
	"+%d Strength",
	"+%d Dexterity",
	"+%d Intelligence",
	"+%d Maximum Health",
	"+%d Critical Hit Chance"
]
@onready var item_box_scene: PackedScene = preload("res://scenes/ui/item_box.tscn")
@onready var stat_affixes: Array = []
@onready var item_spawn_field: Node2D = get_node(spawn_field_path)
@onready var ui_manager: Node = $"../UIManager"

func _ready() -> void:
	stat_affixes = StatAffixLoader.load_all_affixes()

func _select_affixes(rarity: String, affix_pool: Array, max_affixes := 3) -> Array:
	var filtered: Array = []
	
	for affix in affix_pool:
		if affix.rarity_weights.has(rarity):
			filtered.append(affix)
	
	var selected: Array = []
	var pool := filtered.duplicate()
	
	while selected.size() < max_affixes and pool.size() > 0:
		var total_weight = 0
		for affix in pool:
			total_weight += affix.weight
		
		var roll = randi() % total_weight
		var running_total = 0
		
		for i in range (pool.size()):
			var affix = pool[i]
			running_total += affix.weight
			if roll < running_total:
				selected.append(affix)
				pool.remove_at(i)
				break
	
	return selected

func generate_item_box(enemy: EnemyType) -> void:
	if current_item_box:
		current_item_box.queue_free()
		current_item_box = null
	
	var new_box := item_box_scene.instantiate()
	current_item_box = new_box
	
	var item_data := generate_item_data(enemy)
	new_box.set_item(item_data)
	
	emit_signal("item_box_ready", new_box)

func generate_item_data(enemy: EnemyType) -> ItemData:
	var item = ItemData.new()
	item.name = get_random_from_list(names)
	
	item.rarity = _roll_rarity(enemy.rarity_weights)
	
	var req_config = StatBlockConfig.new()
	req_config.source = reqs
	req_config.amount = 2
	req_config.min_val = 10
	req_config.max_val = 30
	req_config.format = "%s: %d"
	
	item.requirements = _generate_lines(req_config)
	
	var stat_count := 2
	if item.rarity == "rare":
		stat_count = 4
	elif item.rarity == "epic":
		stat_count = 5
	elif item.rarity == "unique":
		stat_count = 6
	
	var stat_config = StatBlockConfig.new()
	stat_config.source = stats
	stat_config.amount = stat_count
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

func _roll_rarity(weights: Dictionary) -> String:
	var total_weight := 0
	for rarity in RARITY_ORDER:
		total_weight += weights.get(rarity, 0)
	
	var roll := randi() % total_weight
	var running_total := 0
	
	for rarity in RARITY_ORDER:
		running_total += weights.get(rarity, 0)
		if roll < running_total:
			return rarity
	
	# Fallback scenario
	return "common"

func try_spawn_drop(enemy: EnemyType) -> void:
	if randf() > enemy.drop_chance:
		print("No item dropped")
		return
	
	var item_scene: PackedScene = _select_base_item(enemy.drop_pool)
	if item_scene == null:
		print("No valid item found in drop pool")
		return
	
	var item_data = generate_item_data(enemy)
	
	var item_instance = item_scene.instantiate()
	if item_instance is ItemBase:
		item_instance.item_data = item_data
	
	add_item_to_spawn(item_instance)
	ui_manager.connect_hover_signals(item_instance)

func _select_base_item(pool: ItemDropPool) -> PackedScene:
	var weighted_list: Array[PackedScene] = []
	
	for category in pool.categories:
		var weight = pool.tag_weights.get(category.category_name, 1)
		for scene in category.scenes:
			for i in weight:
				weighted_list.append(scene)
	
	if weighted_list.is_empty():
		return null
	return weighted_list[randi() % weighted_list.size()]

func add_item_to_spawn(item_instance: Node2D) -> void:
	var start_pos = Vector2(64, 64)
	var spacing = Vector2(128, 128)
	var columns = 5
	
	var col = spawned_item_count % columns
	var row = spawned_item_count / columns
	
	item_instance.position = start_pos + Vector2(col * spacing.x, row * spacing.y)
	item_spawn_field.add_child(item_instance)
	spawned_item_count += 1
