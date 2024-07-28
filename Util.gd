class_name Util

static func getRandomDictEntry(dict: Dictionary):
	var size = dict.size()
	var random_key = dict.keys()[randi() % size]
	var entry = dict[random_key]
	return entry
