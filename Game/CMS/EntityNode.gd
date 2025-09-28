extends Node2D # можно изменить на Node, Node3D, пофиг
class_name Entity

# я пытался не привязывать Entity к node, но это была жопа какая-то, ну или я говнокодер

## Ссылка на EntityData, ВАЖНО сохранять это единственной прямой ссылкой, иначе возможна утечка памяти
@export var data : EntityData

var uid : String = ""


func _enter_tree() -> void:
	CMS.register_entity(self)
	data = data.duplicate_deep(Resource.DEEP_DUPLICATE_ALL) # для уникальности ресурса
	data.entity = self
	for t in data.Tags:
		t.entity_node = self
		t._on_init_data(data)

func _ready() -> void:
	for t in data.Tags:
		t.OnEntityReady()

func _exit_tree() -> void:
	data.UnregisterTags() 
	CMS.unregister_entity(self)
