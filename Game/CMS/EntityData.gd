extends Resource
## Собственно сам Entity, имеет Тэги, НА ТЭГИ НЕ НАДО ДЕЛАТЬ ПОСТОЯННЫХ ССЫЛОК, ЭТО НЕ КРУТО БЛИН
class_name EntityData


@export var Tags : Array[Tag]
var entity : Entity


func Unregister():
	for tag in Tags:
		tag._on_unregister()
		assert(tag.get_reference_count() <= 2, "Too many references: " + str(tag.get_reference_count()) + " to the Tag, this may create memory leak, must be <= 2")
	assert(get_reference_count() <= 2, "Too many references: " + str(get_reference_count()) + " to the EntityData, this may create memory leak, must be <= 2")

# если ты читаешь эту ошибку, значит ты не почистил ссылки на tag'и и EntityData, это может вызвать утечки памяти
