extends Resource
## Serializable resource that defines the configuration and behavior of an Entity.
## Contains an array of tags (Tag resources), which each encapsulate logic or modifiers.
##
## This data is duplicated at runtime to ensure each Entity instance is isolated.
class_name EntityData

## All tags that define this entity's behavior
@export var Tags: Array[Tag]

## Runtime reference to the owning Entity node
var entity: Entity

func Unregister():
	for tag in Tags:
		tag._on_unregister()
		assert(tag.get_reference_count() <= 2, "Memory leak detected: Tag has too many references.")
	assert(get_reference_count() <= 2, "Memory leak detected: EntityData has too many references.")

# if you get an error here, check if you are saving
# the reference to tags or EntityData somewhere
