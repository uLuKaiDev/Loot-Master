extends Control

signal item_generated

@onready var names: Array = [
	"Grimbrand",
	"Shadowfang",
	"Doomreaver",
	"Nightcleaver",
	"Stormrend",
	"Vileheart",
	"Soulreaper",
	"Bloodhowl",
	"Frostbite",
	"Embermaw"
]
@onready var reqs: Array = [
	"Strength",
	"Dexterity",
	"Intelligence",
	"Spirit"
]
@onready var stats: Array = [
	"+%d Attack Damage",
	"+%d Critical Strike Chance",
	"+%d Life Leech",
	"+%d Fire Resistance",
	"+%d Cold Resistance",
	"+%d Attack Speed",
	"+%d Mana Regeneration",
	"+%d Armor",
	"+%d Spell Power",
	"+%d Poison Damage over Time"
]



@onready var item_box_scene: PackedScene = preload("res://scenes/ui/item_box.tscn")
@onready var generate_button: Button = $GenerateButton

var current_item_box: Node = null

func _ready() -> void:
	generate_button.pressed.connect(_on_generate_button_pressed)


func _on_generate_button_pressed() -> void:
	if current_item_box:
		remove_child(current_item_box)
		current_item_box.queue_free()
		current_item_box = null
	
	var new_item_box = item_box_scene.instantiate()
	add_child(new_item_box)
	current_item_box = new_item_box
	
	_generate_item_values(current_item_box)
	

func get_random_from_list(list: Array) -> String:
	if list.size() != 0:
		return list[randi_range(0, list.size()-1)]
	return ""

func get_multiple_random_from_list(source_list: Array, amount: int) -> Array:
	var pool = source_list.duplicate()
	pool.shuffle()
	return pool.slice(0, amount)
	
func _generate_item_values(new_item_box):
	var random_name = get_random_from_list(names)
	var reqs_array = get_multiple_random_from_list(reqs, 2)
	var stats_array = get_multiple_random_from_list(stats, randi_range(1, 6))
	
	new_item_box.find_child("Name").text = random_name
	
	var req_lines = []
	for req in reqs_array:
		req_lines.append("%s: %d" % [req, randi_range(10,30)])
	new_item_box.find_child("Requirements").text = "\n".join(req_lines)
	
	var stat_lines = []
	for stat_template in stats_array:
		stat_lines.append(stat_template % randi_range(1, 30))
	new_item_box.find_child("Statistics").text = "\n".join(stat_lines)
	
	if new_item_box is Control:
		new_item_box.position = Vector2(625, 50)
		
	emit_signal("item_generated")
