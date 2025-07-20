extends Panel

@export var panel_padding: Vector2 = Vector2(40,35)

func set_item(data):
	$MarginContainer/VBoxContainer/Name.text = data.name
	$MarginContainer/VBoxContainer/Requirements.text = "\n".join(data.requirements)
	$MarginContainer/VBoxContainer/Statistics.text = "\n".join(data.statistics)
	_set_rarity_label(data.rarity)

	
	call_deferred("resize_to_contents")

func resize_to_contents():
	# await get_tree().process_frame
	var content_size: Vector2 = $MarginContainer/VBoxContainer.get_combined_minimum_size()
	custom_minimum_size = content_size + panel_padding

func _set_rarity_label(rarity: String) -> void:
	var label := $MarginContainer/VBoxContainer/Rarity
	label.text = "Rarity: %s" % rarity.capitalize()
	label.add_theme_color_override("font_color", _get_rarity_color(rarity))


func _get_rarity_color(rarity: String) -> Color:
	match rarity:
		"common": return Color.WHITE
		"uncommon": return Color(0.3, 1.0, 0.3) # greenish
		"rare": return Color(0.3, 0.6, 1.0)     # blue
		"epic": return Color(0.7, 0.3, 1.0)     # purple
		"unique": return Color(1.0, 0.6, 0.0)   # orange
		_: return Color.GRAY
