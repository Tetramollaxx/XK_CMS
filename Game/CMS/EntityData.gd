extends Resource
class_name EntityData


@export var Tags : Array[Tag]
var entity : Entity


func UnregisterTags():
	for tag in Tags:
		tag._on_unregister()
		assert(tag.get_reference_count() <= 2, "Too many references: " + str(tag.get_reference_count()) + " to the Tag, this may create memory leak, must be <= 2")
	print(get_reference_count())
	assert(get_reference_count() <= 2, "Too many references: " + str(get_reference_count()) + " to the EntityData, this may create memory leak, must be <= 2")

# если ты читаешь эту ошибку, значит ты не почистил ссылки на tag'и и EntityData, это может вызвать утечки памяти
