@abstract
extends Resource
class_name Tag

var entity_node : Entity

func _on_init_data(data : EntityData):
	Interactions.register_object(self)
	OnInitData(data)

@warning_ignore("unused_parameter") # бесит !!!
func OnInitData(data : EntityData) : pass # virtual типо _ready() для тэгов

func OnEntityReady() : pass

func OnUnregistred() :
	if self is TagMemoryLeak:
		for p in get_property_list():
			self.set(p.get("name"), null)
