extends Node
# Статический класс, который хранит всех Entity, позволяет получать ресурсы из папок, а также получать entity
class_name CMS

## Все активные сущности [uid : Entity]
static var entities: Dictionary = {}

## Все когда-либо выданные ключи, даже если объект был удалён (чтобы не было повторений в id)
static var all_keys: Array[String] = []

## Включить или отключить бесячий print
static var debug_print : bool = false


static func get_entity(key: String) -> Entity:
	return entities.get(key, null)


static func get_entity_data(key: String) -> EntityData:
	var ent: Entity = get_entity(key)
	return null if ent == null else ent.data

## генератор id для списка
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


static func register_entity(entity: Entity) -> void:
	if entity.uid == "":
		entity.uid = generate_uid(entity)
	entities[entity.uid] = entity
	if debug_print:
		print("register entity: ", entity.uid, " entity count : ", entities.size())


static func unregister_entity(entity: Entity) -> void:
	entities.erase(entity.uid)
	if debug_print:
		print("unregister entity: ", entity.uid, " entity count : ", entities.size())


static func get_resources_in_directory(path: String) -> Array[String]:
	var file_paths: Array[String] = []
	var loaded : PackedStringArray = ResourceLoader.list_directory(path)
	
	for i in loaded:
		if i.contains(".tres"):
			file_paths.append( path + i )
	
	return file_paths
