extends Node
## Херовый аналог интеракторов хк. Находит и даёт все узлы, реализующие метод, узлы должны находится в группе Implementors. Также позволяет находить ресурсы (Тэги) реализующие нужные методы, однако ресурcы нужно регестрировать
class_name InteractionManger

## Все те, кого он может вызвать, для Node есть возможность быть добавленной в группу "Implementers", через ui
var objects : Array[Object]



func register_object(obj : Object):
	if !objects.has(obj):
		objects.append(obj)

func unregister_object(obj : Object):
	objects.erase(obj)

## даём тем, кто просит всех тех, у кого есть данный метод
func get_implementers(method_name : String):
	var result : Array[Object]
	for obj in objects:
		if obj.has_method(method_name):
			result.append(obj)
	for n in get_tree().get_nodes_in_group("Implementers"):
		if !result.has(n) and n.has_method(method_name):
			result.append(n)
	return result

## вызываем всех тех, у кого есть метод
func call_implementers(method_name : String, ...args : Array[Variant]):
	for imp in get_implementers(method_name):
		imp.callv(method_name, args)
