extends Node2D
class_name Main


@onready var dice: Dice = $Dice

var resources  : Array[String]


var memory_leak_references : Array[EntityData]


func _on_ramdomize_button_pressed() -> void:
	var pos : Vector2 = Vector2(543.0, 715.0)
	if dice:
		pos = dice.global_position
		dice.queue_free()
	dice = load("res://Game/CMS/Demo/scenes/dice.tscn").instantiate()
	
	resources = CMS.get_resources_in_directory("res://Game/CMS/Demo/Entities/")
	
	dice.data = ResourceLoader.load(resources.pick_random())
	memory_leak_references.append(dice.data)
	dice.global_position = pos
	add_child(dice)


func _on_generate_button_pressed() -> void:
	var pos : Vector2 = Vector2(543.0, 715.0)
	if dice:
		pos = dice.global_position
		dice.queue_free()
	dice = load("res://Game/CMS/Demo/scenes/dice.tscn").instantiate()
	
	var new_data : EntityData = EntityData.new()
	var visual_elements_list = ["Eyes", "SunGlasses", "FireBall", "Sword"]
	var selected_elements: Array
	
	for i in randi_range(1,3):
		var tag_element = TagShowVisualElement.new()
		tag_element.element_name = visual_elements_list.pick_random()
		visual_elements_list.erase(tag_element.element_name)
		new_data.Tags.append(tag_element)
		selected_elements.append(tag_element.element_name)
	
	var tag_name : TagName = TagName.new()
	for s in selected_elements:
		tag_name.Name += " " + s + " "
	tag_name.Name += " dice"
	new_data.Tags.append(tag_name)
	
	var color = Color(randf(), randf(), randf())
	var is_invisible : bool = randf() < 0.1
	if is_invisible:
		color.a = 0
	
	var tag_color : TagChangeBaseColor = TagChangeBaseColor.new()
	tag_color.new_color = color
	new_data.Tags.append(tag_color)
	
	var tag_desc : TagDescription = TagDescription.new()
	
	tag_desc.description = "random generated dice."
	if is_invisible:
		tag_name.Name = "Invisible " + tag_name.Name
		tag_desc.description += " The dice is invisible "
	else:
		tag_desc.description += " The color of dice is: " + str(color) + " "
	new_data.Tags.append(tag_desc)
	
	var roll_values : Array[int] = [1,2,3,4,5,6]
	
	if randf() < 0.3:
		if randf() < 0.5:
			tag_desc.description += " always odd "
			roll_values = [1,3,5]
		else:
			tag_desc.description += " always even "
			roll_values = [2,4,6]
	
	var roll_tag : TagRollValueOnPlay = TagRollValueOnPlay.new()
	roll_tag.AllowedValues = roll_values
	new_data.Tags.append(roll_tag)
	
	if randf() < 0.3:
		var jump_on_play_tag : TagJumpOnPlay = TagJumpOnPlay.new()
		tag_desc.description += " jumps on play "
		new_data.Tags.append(jump_on_play_tag)
	
	
	dice.data = new_data
	dice.global_position = pos
	add_child(dice)


func _on_play_button_pressed() -> void:
	Interactions.call_implementers("OnPlayedDice", dice)


func _on_delete_dice_button_pressed() -> void:
	if dice:
		dice.queue_free()



func _on_save_button_pressed() -> void:
	if Engine.is_embedded_in_editor():
		var res = dice.data
		var path : String = "res://Game/CMS/Demo/Entities/" + "generated_dice_" + str(Time.get_unix_time_from_system()) + str(randi()) + ".tres"
		ResourceSaver.save(res, path)
	else:
		%Label.show()
		await get_tree().create_timer(1).timeout
		%Label.hide()
