extends Control

signal item_generated

@onready var generate_button: Button = $GenerateButton
@onready var item_manager: ItemManager = $ItemManager
@onready var item_box_scene: PackedScene = preload("res://scenes/ui/item_box.tscn")

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
	
	var item_data = item_manager.generate_item_data()
	new_item_box.set_item(item_data)
	item_generated.connect(new_item_box._on_item_generated, CONNECT_ONE_SHOT)
	emit_signal("item_generated")
