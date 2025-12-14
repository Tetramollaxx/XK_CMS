extends Node2D
class_name demo_main


var entity : Entity

func _ready() -> void:
	entity = CMS.create_entity(self, "res://Game/CMS/Entities/demo_entity.tres")

func _on_button_pressed() -> void:
	Interactor.call_all("OnButtonPressed", $Button, entity)
