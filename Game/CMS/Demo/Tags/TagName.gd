extends Tag
class_name TagName


@export var Name : String


func OnEntityReady():
	(entity_node as Dice).name_label.text = Name
