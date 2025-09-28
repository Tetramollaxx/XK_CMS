extends Entity
class_name Dice



@onready var description_label: Label = $Panel2/DescriptionLabel
@onready var name_label: Label = $NameLabel
@onready var base: Panel = $Base
@onready var rolled_value_label: Label = $RolledValueLabel



func get_visual_elements():
	return %VisualElements.get_children()
