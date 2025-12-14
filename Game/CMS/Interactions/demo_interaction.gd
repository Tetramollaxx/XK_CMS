extends Interaction
class_name DemoInteraction


func OnButtonPressed(button : Button, entity : Entity):
	if entity.Is(TagBehaviourOnClick):
		match entity.Get(TagBehaviourOnClick).current_beh:
			TagBehaviourOnClick.behaviours.Jump:
				var t : Tween = get_tree().create_tween()
				t.tween_property(button, "scale", 1.2 * Vector2.ONE, 0.1)
				await t.finished
				t = get_tree().create_tween()
				t.tween_property(button, "scale", Vector2.ONE, 0.1)
			TagBehaviourOnClick.behaviours.Hide:
				button.hide()
			TagBehaviourOnClick.behaviours.Quit:
				get_tree().quit()
