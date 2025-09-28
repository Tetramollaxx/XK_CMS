extends Tag
class_name TagChangeBaseColor

@export var new_color : Color

func OnEntityReady():
	(entity_node as Dice).base.modulate = new_color
