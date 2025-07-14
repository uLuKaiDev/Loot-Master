extends Panel

@export var panel_padding: Vector2 = Vector2(20,20)

func set_item(data):
	$VBoxContainer/Name.text = data.name
	$VBoxContainer/Requirements.text = "\n".join(data.requirements)
	$VBoxContainer/Statistics.text = "\n".join(data.statistics)
	
	call_deferred("resize_to_contents")


func resize_to_contents():
	# await get_tree().process_frame
	var content_size: Vector2 = $VBoxContainer.get_combined_minimum_size()
	custom_minimum_size = content_size + panel_padding
