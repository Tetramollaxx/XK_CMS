extends Tag
class_name TagRollValueOnPlay

@export var AllowedValues : Array[int] = [1,2,3,4,5,6]
var RolledValue : int

func OnPlayedDice(dice : Dice):
	if entity_node == dice:
		RolledValue = AllowedValues.pick_random()
		(entity_node as Dice).rolled_value_label.text = str(RolledValue)
