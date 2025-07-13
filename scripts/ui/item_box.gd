extends Panel

func set_item(data):
	$VBoxContainer/Name.text = data.name
	$VBoxContainer/Requirements.text = "\n".join(data.requirements)
	$VBoxContainer/Statistics.text = "\n".join(data.statistics)

func _on_item_generated():
	print("Signal received")
