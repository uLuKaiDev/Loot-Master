class_name ItemBase
extends Area2D

@export var item_data: ItemData

func _ready() -> void:
	if item_data:
		print("Spawned: ", item_data.name, "with rarity: ", item_data.rarity)
