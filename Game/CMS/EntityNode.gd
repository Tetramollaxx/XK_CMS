extends Node2D # or Node / Node3D
## Represents a live entity in the scene tree. This node serves as the runtime container
## for EntityData (a resource that defines behavior and configuration).
##
## When the node enters the scene tree, it duplicates its EntityData to ensure isolation,
## initializes all tags, and registers itself into the CMS.
##
## When the node exits the scene tree, all tags are unregistered and references are cleared.
##
## This allows Entity behavior to be defined entirely through tags.
class_name Entity

## Reference to data definition (.tres)
@export var data: EntityData

## Unique runtime key assigned via CMS
var uid: String = ""

func _enter_tree() -> void:
	CMS.register_entity(self)
	data = data.duplicate_deep(Resource.DEEP_DUPLICATE_ALL)
	data.entity = self
	for t in data.Tags:
		t.entity_node = self
		t._on_init_data(data)

func _ready() -> void:
	for t in data.Tags:
		t.OnEntityReady()

func _exit_tree() -> void:
	data.Unregister()
	CMS.unregister_entity(self)
