extends Tag
## К сожалению, мой код не идеален... Если тэг или кто-либо ещё будет хранить постоянную ссылку на 
## ресурсы EntityData или на Tag, то после после удаления EntityNode эти ресурсы не будут удалены
## это значит будет утечка памяти, этот скрипт - пример Tag'а который ведёт к утечкам памяти
## утечки можно проверить в Отладчик->Мониторинг-> кол-во объектов, ресурсов и узлов.
class_name TagMemoryLeak

#var reference_to_the_data : EntityData
#var reference_to_the_tags : Array[Tag]


func OnPlayedDice(_d : Dice):
	for t in entity_node.data.Tags:
		pass
		#reference_to_the_tags.append(t)
		#(entity_node.get_parent() as Main).memory_leak.append(entity_node.data)
	

#func OnUnregistred(): # Чтобы не было утечки памяти, нужно удалять ссылки, или вообще не создавать ссылки
	#reference_to_the_tags = [null]
	#reference_to_the_data = null
