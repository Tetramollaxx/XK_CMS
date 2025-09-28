extends Tag
class_name TagShowVisualElement


@export var element_name : String


func OnEntityReady():
	var elements = (entity_node as Dice).get_visual_elements()
	for e in elements:
		if e.name == element_name:
			e.show()
