extends Tag
class_name TagJumpOnPlay

var _is_in_animation
func OnPlayedDice(dice : Dice):
	if entity_node != dice:
		return
	if _is_in_animation:
		return
	_is_in_animation = true
	var t : Tween = entity_node.get_tree().create_tween()
	t.tween_property(entity_node, "scale", 1.1 * Vector2.ONE, 0.1)
	await t.finished
	await entity_node.get_tree().create_timer(0.1).timeout
	t = entity_node.get_tree().create_tween()
	t.tween_property(entity_node, "scale", Vector2.ONE, 0.1)
	await t.finished
	_is_in_animation = false
