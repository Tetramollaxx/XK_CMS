extends Tag
class_name TagDescription


@export_multiline var description : String


func OnEntityReady():
	(entity_node as Dice).description_label.text = description
