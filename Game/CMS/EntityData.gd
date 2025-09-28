extends Resource
class_name EntityData


@export var Tags : Array[Tag]
var entity : Entity


func UnregisterTags():
	for tag in Tags:
		Interactions.unregister_object(tag)
		tag.OnUnregistred()
