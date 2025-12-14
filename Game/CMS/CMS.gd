extends Node
class_name CMS


static func create_entity(bind_to : Node, path : String):
	var entity = load_resource(path)
	
	entity.Init(bind_to)
	
	return entity

static func load_resource(path: String):
	if ResourceLoader.exists(path):
		return ResourceLoader.load(path)
	return null

static func save_resource(res: Resource, to_path: String):
	return ResourceSaver.save(res, to_path)

static func get_resources_in_directory(path: String) -> Array[String]:
	var file_paths: Array[String] = []
	var loaded: PackedStringArray = ResourceLoader.list_directory(path)
	for i in loaded:
		if i.ends_with(".tres"):
			file_paths.append(path + i)
	return file_paths
	
static func get_script_in_directory(path: String) -> Array[String]:
	var file_paths: Array[String] = []
	var loaded: PackedStringArray = ResourceLoader.list_directory(path)
	for i in loaded:
		if i.ends_with(".gd"):
			file_paths.append(path + i)
	return file_paths
