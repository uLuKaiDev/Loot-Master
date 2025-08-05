class_name ItemBase
extends Area2D

signal hovered(item_data: ItemData)
signal unhovered

@export var item_data: ItemData

var item_box: Control

func _ready() -> void:
	if item_data:
		print("Spawned: ", item_data.name, " with rarity: ", item_data.rarity)
	
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered():
	if item_data:
		emit_signal("hovered", item_data)
		print("Hovering over: ", item_data.name)

func _on_mouse_exited():
	emit_signal("unhovered")
	print("Left: ", item_data.name)
