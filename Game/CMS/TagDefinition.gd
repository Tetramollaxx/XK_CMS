@abstract
extends Resource
class_name Tag

var entity_node : Entity

func _on_init_data(data : EntityData):
	set_meta("Interaction", true)
	OnInitData(data)


@warning_ignore("unused_parameter") # бесит !!!
func OnInitData(data : EntityData) : pass # virtual типо _ready() для тэгов

func OnEntityReady() : pass
func OnUnregister()  : pass


func _on_unregister() :
	OnUnregister()
	for p in self.get_property_list(): # специально чищу тэг, чтобы не было утечек памяти...
		if p.type == TYPE_ARRAY:
			self.set(p.name, [])
		if p.type == TYPE_DICTIONARY:
			self.set(p.name, {})
		if p.type == TYPE_OBJECT:
			self.set(p.name, null)
