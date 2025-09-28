extends Node
class_name InteractionManager

var ClearThreshold : int = 5

var _interactions : Array[WeakRef]
var _visited : Array[int]

var DebugPrint : bool = false

func _ready() -> void:
	_initialize_interactions()
	
	get_tree().node_added.connect(_on_node_added)
	get_tree().node_removed.connect(_on_node_deleted)


func _on_node_added(n : Node):
	if n.has_meta("Interaction") and n.get_meta("Interaction"):
		if ! _has(n):
			_interactions.append(weakref(n))
	var props := n.get_property_list()
	for p in props:
		var value = n.get(p.name)
		_process_prop(value)

func _on_node_deleted(n : Node):
	if _has(n):
		for i in _interactions.size():
			if _interactions[i].get_ref() == n:
				_interactions.remove_at(i)
	if _interactions.size() > ClearThreshold:
		for i in range(_interactions.size() -1, -1, -1):
			if _interactions[i] == null:
				_interactions.remove_at(i)
				continue
			if !is_instance_valid(_interactions[i].get_ref()):
				_interactions.remove_at(i)
				continue
			if _interactions[i].get_ref() == null:
				_interactions.remove_at(i)
				continue

func _initialize_interactions():
	var root = get_tree().root
	
	for c in root.get_children():
		_process_node_recursive(c)
	
	if DebugPrint:
		for i in _interactions:
			print("registerd interaction : ", i.get_ref())


func _process_node_recursive(n : Node):
	
	if _was_visited(n):
		return
	_mark_visited(n)
	
	if n.has_meta("Interaction") and n.get_meta("Interaction"):
		if ! _has(n):
			_interactions.append(weakref(n))
	for c in n.get_children():
		_process_node_recursive(c)
	
	if n is Entity:
		pass
	
	var props := n.get_property_list()
	for p in props:
		var value = n.get(p.name)
		_process_prop(value)

func _process_prop(value):
	if value == null:
		return
	
	if _was_visited(value):
		return
	_mark_visited(value)
	
	if typeof(value) == TYPE_ARRAY:
		for i in value:
			_process_prop(i)
	elif typeof(value) == TYPE_DICTIONARY:
		for k in value.keys():
			_process_prop(value[k])
	elif typeof(value) == TYPE_OBJECT:
		if value.has_meta("Interaction") and value.get_meta("Interaction"):
			if ! _has(value):
				_interactions.append(weakref(value))
		var props = value.get_property_list()
		for p in props:
			var v = value.get(p.name)
			
			if typeof(v) == typeof(value):
				if v == value:
					continue
			
			_process_prop(v)

func _has(obj : Object):
	for i in _interactions:
		if i.get_ref() == obj:
			return true
	return false

func _mark_visited(obj : Variant):
	if !obj is Object:
		return
	_visited.append(obj.get_instance_id())

func _was_visited(obj : Variant):
	if !obj is Object:
		return false
	return _visited.has(obj.get_instance_id())


func get_implementers(method_name : String) -> Array:
	var to_return : Array[Object]
	
	for i in range(_interactions.size() -1, -1, -1):
		if _interactions[i] == null:
			_interactions.remove_at(i)
			continue
		if !is_instance_valid(_interactions[i].get_ref()):
			_interactions.remove_at(i)
			continue
		if _interactions[i].get_ref() == null:
			_interactions.remove_at(i)
			continue
		if _interactions[i].get_ref().has_method(method_name):
			to_return.append(_interactions[i].get_ref())
		
		_visited = []
	
	if DebugPrint:
		print("interactions count: ", _interactions.size())
	return to_return

func call_implementers(method_name : String, ...args : Array[Variant]):
	var a = get_implementers(method_name)
	for i in a:
		i.callv(method_name, args)
