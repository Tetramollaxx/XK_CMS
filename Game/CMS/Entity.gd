extends Resource
class_name Entity

@export var Tags: Array[Tag]

var node: Node

func Init(bind_to : Node):
	node = bind_to

func Is(type : Variant) -> bool:
	for i in Tags:
		if is_instance_of(i,type):
			return true
	return false

func Get(type : Variant) -> Tag:
	for i in Tags:
		if is_instance_of(i, type):
			return i
	return null

func GetAll(type : Variant) -> Array[Tag]:
	var to_return : Array[Tag]
	for i in Tags:
		if is_instance_of(i, type):
			to_return.append(i)
	return to_return
