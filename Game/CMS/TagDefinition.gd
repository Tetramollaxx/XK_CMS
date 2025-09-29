@abstract
extends Resource
## Base class for all tag components.
##
## Tags define modular behaviors and can listen to various interaction events.
## You can attach multiple tags to a single EntityData resource.
##
## Tags are automatically registered with the InteractionManager using metadata.
class_name Tag

## Runtime reference to the Entity node
var entity_node: Entity

## Called after Tag is duplicated and assigned to Entity
func _on_init_data(data: EntityData):
	set_meta("Interaction", true)
	OnInitData(data)

## Lifecycle hooks
@warning_ignore("unused_parameter")
func OnInitData(data: EntityData): pass
func OnEntityReady(): pass
func OnUnregister(): pass

## Called by EntityData.Unregister() — resets Tag memory to avoid leaks
func _on_unregister():
	OnUnregister()
	for p in self.get_property_list():
		match p.type:
			TYPE_ARRAY:
				self.set(p.name, [])
			TYPE_DICTIONARY:
				self.set(p.name, {})
			TYPE_OBJECT:
				self.set(p.name, null)
