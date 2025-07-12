extends Panel

func _ready() -> void:
	var main = get_tree().get_root().get_node("Main")
	if main and main.has_signal("item_generated"):
		main.item_generated.connect(_on_item_generated)

func _on_item_generated():
	print("Signal received, running func")
	
func _exit_tree() -> void:
	var main = get_tree().get_root().get_node("Main")
	if main and main.is_connected("item_generated", _on_item_generated):
		main.item_generated.disconnect(_on_item_generated)
