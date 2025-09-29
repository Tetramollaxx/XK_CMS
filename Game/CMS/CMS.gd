extends Node
## Central manager for all currently loaded Entity nodes.
## Provides a global dictionary of [uid : Entity] and various utilities.
##
## This allows you to retrieve entities or their data by string keys (uid),
## without needing persistent object references.
class_name CMS

## Global registry of active Entity nodes: [uid : Entity]
static var entities: Dictionary = {}

## All previously issued entity keys (to avoid duplication)
static var all_keys: Array[String] = []

## Enable debug output
static var debug_print: bool = false

## Get the Entity node by its uid, or null if not found
static func get_entity(key: String) -> Entity:
	return entities.get(key, null)

## Returns the data of a given entity by uid
static func get_entity_data(key: String) -> EntityData:
	var ent: Entity = get_entity(key)
	return null if ent == null else ent.data

## Creates a unique ID for the given entity (based on its name and counter)
static func generate_uid(entity: Node) -> String:
	var base := entity.name.strip_edges()
	if base == "":
		base = "entity"
	var count := 1
	var uid := "%s_%d" % [base, count]
	while all_keys.has(uid):
		count += 1
		uid = "%s_%d" % [base, count]
	all_keys.append(uid)
	if all_keys.size() > 150:
		all_keys.remove_at(0)
	return uid

## Registers an entity into the global dictionary
static func register_entity(entity: Entity) -> void:
	if entity.uid == "":
		entity.uid = generate_uid(entity)
	entities[entity.uid] = entity
	if debug_print:
		print("Registered entity: ", entity.uid, " (total: ", entities.size(), ")")

static func unregister_entity(entity: Entity) -> void:
	entities.erase(entity.uid)
	if debug_print:
		print("Unregistered entity: ", entity.uid, " (total: ", entities.size(), ")")

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
