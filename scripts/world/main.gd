extends Control

@onready var generate_button: Button = $UILayer/UIRoot/VBoxContainer/GenerateButton
@onready var enemy_selector: OptionButton = $UILayer/UIRoot/VBoxContainer/EnemySelector
@onready var item_manager: ItemManager = $ItemManager
@onready var ui_manager: Node = $UIManager

var enemy_types: Array = [
	preload("res://scripts/resources/enemies/normal_enemy.tres"),
	preload("res://scripts/resources/enemies/elite_enemy.tres"),
	preload("res://scripts/resources/enemies/boss_enemy.tres")
	]

func _ready() -> void:
	for enemy_type in enemy_types:
		enemy_selector.add_item(enemy_type.name)
	
	generate_button.pressed.connect(_on_generate_button_pressed)
	item_manager.item_box_ready.connect(ui_manager.display_item_box)

func _on_generate_button_pressed() -> void:
	var selected_index = enemy_selector.get_selected_id()
	var selected_enemy = enemy_types[selected_index]
	
	item_manager.generate_item_box(selected_enemy)
