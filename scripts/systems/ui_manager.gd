extends Node

@export var container_node_path: NodePath
@onready var container: Node = get_node(container_node_path)

func display_item_box(box: Control) -> void:
	container.add_child(box)
	await get_tree().process_frame
	
	box.resize_to_contents()
	var content_size = box.get_combined_minimum_size()
	box.position = _get_safe_position(content_size)

func _get_safe_position(size: Vector2) -> Vector2:
	var screen_size = get_viewport().get_visible_rect().size
	var position = Vector2(20, 20)
	
	if size.x > screen_size.x:
		position.x = screen_size.x - size.x
	if size.y > screen_size.y:
		position.y = screen_size.y - size.y
	
	return position
