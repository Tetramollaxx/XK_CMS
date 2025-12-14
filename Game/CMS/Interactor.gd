extends Node
## Interactor, !!! must be an autoload !!!
class_name InteractionManager


var _interactions : Array[Interaction]


func _ready() -> void:
	var paths : Array[String] = CMS.get_script_in_directory("res://Game/CMS/Interactions/")
	
	for p in paths:
		var i = CMS.load_resource(p).new()
		_interactions.append(i)
		add_child(i)

func get_implementers(method_name: String) -> Array[Interaction]:
	var to_return: Array[Interaction]
	for i in _interactions.size():
		if _interactions[i].has_method(method_name):
			to_return.append(_interactions[i])
	return to_return

func call_all(method_name: String, ...args: Array[Variant]):
	for i in get_implementers(method_name):
		i.callv(method_name, args)

func call_async(method_name: String, ...args: Array[Variant]):
	for i in get_implementers(method_name):
		await i.callv(method_name, args)
