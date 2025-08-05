extends Node

@export var container_node_path: NodePath
@export var global_tooltip_node_path: NodePath

@onready var container: Node = get_node(container_node_path)
@onready var global_tooltip: Control = get_node(global_tooltip_node_path)

var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport().size

func _process(_delta: float) -> void:
	if global_tooltip.visible:
		var pos = get_viewport().get_mouse_position() + Vector2(16, 16)
		
		pos.x = clamp(pos.x, 0, screen_size.x - global_tooltip.size.x)
		pos.y = clamp(pos.y, 0, screen_size.y - global_tooltip.size.y)
		
		global_tooltip.position = pos

func display_item_box(box: Control) -> void:
	container.add_child(box)
	await get_tree().process_frame
	
	box.resize_to_contents()
	var content_size = box.get_combined_minimum_size()
	box.position = _get_safe_position(content_size)

func connect_hover_signals(item_instance: ItemBase) -> void:
	item_instance.hovered.connect(_on_item_hovered)
	item_instance.unhovered.connect(_on_item_unhovered)

func _on_item_hovered(data: ItemData) -> void:
	global_tooltip.populate_from_item_data(data)
	global_tooltip.visible = true
	

func _on_item_unhovered() -> void:
	global_tooltip.visible = false

func _get_safe_position(size: Vector2) -> Vector2:
	var screen_size = get_viewport().get_visible_rect().size
	var position = Vector2(20, 20)
	
	if size.x > screen_size.x:
		position.x = screen_size.x - size.x
	if size.y > screen_size.y:
		position.y = screen_size.y - size.y
	
	return position
