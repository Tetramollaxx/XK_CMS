extends Resource
## Serializable resource that defines the configuration and behavior of an Entity.
## Contains an array of tags (Tag resources), which each encapsulate logic or modifiers.
##
## This data is duplicated at runtime to ensure each Entity instance is isolated.
class_name EntityData

## All tags that define this entity's behavior
@export var Tags: Array[Tag]

## Runtime reference to the owning Entity node
#var entity: Entity
var node : Node


func InitializeEntity(_node : Node):
	node = _node
	node.connect("ready", Callable(self, "_on_node_ready"))
	node.connect("tree_exiting", Callable(self, "_on_node_exited_tree"))
	
	for t in Tags:
		t.set_meta("Interaction", true)
		t.entity_node = node


func _on_node_ready():
	for t in Tags:
		t.OnEntityReady()


func _on_node_exited_tree():
	Unregister()


func GetTag(type : Variant) -> Tag:
	for t in Tags:
		if is_instance_of(t, type):
			return t
	return null


func Unregister():
	node = null
	CMS.all_entities.remove_at(CMS.all_entities.find(self))
	for tag in Tags:
		tag._on_unregister()
		assert(tag.get_reference_count() <= 2, "Memory leak detected: Tag has too many references.")
	assert(get_reference_count() <= 2, "Memory leak detected: EntityData has too many references.")

# if you get an error here, check if you are saving
# the reference to tags or EntityData somewhere
