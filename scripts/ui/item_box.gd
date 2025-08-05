extends Panel

@export var panel_padding: Vector2 = Vector2(40,35)

@onready var name_label := $MarginContainer/VBoxContainer/Name
@onready var rarity_label := $MarginContainer/VBoxContainer/Rarity
@onready var reqs_label := $MarginContainer/VBoxContainer/Requirements
@onready var stats_label := $MarginContainer/VBoxContainer/Statistics

func populate_from_item_data(data: ItemData) -> void:
	name_label.text = data.name
	reqs_label.text = "\n".join(data.requirements)
	stats_label.text = "\n".join(data.statistics)
	_set_rarity_label(data.rarity)
	call_deferred("resize_to_contents")

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
	rarity_label.text = "Rarity: %s" % rarity.capitalize()
	rarity_label.add_theme_color_override("font_color", _get_rarity_color(rarity))

func _get_rarity_color(rarity: String) -> Color:
	match rarity:
		"common": return Color.WHITE
		"uncommon": return Color(0.3, 1.0, 0.3) # green
		"rare": return Color(0.3, 0.6, 1.0)     # blue
		"epic": return Color(0.7, 0.3, 1.0)     # purple
		"unique": return Color(1.0, 0.6, 0.0)   # orange
		_: return Color.GRAY
