class_name StatAffixLoader
extends Node


static func load_all_affixes(path := "res://scripts/resources/affixes") -> Array:
	var affixes: Array = []
	var dir = DirAccess.open(path)
	
	if dir == null:
		push_error("Failed to open affix directory: %s" % path)
		return affixes
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if file_name.ends_with(".tres"):
			var full_path = path + "/" + file_name
			var resource = load(full_path)
			if resource is StatAffix:
				affixes.append(resource)
		file_name = dir.get_next()
	
	dir.list_dir_end()
	return affixes
