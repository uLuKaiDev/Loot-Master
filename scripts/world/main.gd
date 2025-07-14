extends Control

@onready var generate_button: Button = $GenerateButton
@onready var item_manager: ItemManager = $ItemManager
@onready var ui_manager: Node = $UIManager


func _ready() -> void:
	generate_button.pressed.connect(_on_generate_button_pressed)
	item_manager.item_box_ready.connect(ui_manager.display_item_box)


func _on_generate_button_pressed() -> void:
	item_manager.generate_item_box()
