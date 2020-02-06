extends HBoxContainer

var previous_value = 0
export(PackedScene) var entity_miniature_node

func _ready():
	pass

func _on_AddMob_button_down():
	reset()
	get_parent().visible = true
	var mob_dictionary = get_tree().get_current_scene().get_mob_dictionary()
	for one_mob in mob_dictionary :
		var new_entity_miniature_node = entity_miniature_node.instance()
		var id = String(one_mob.id)
		new_entity_miniature_node.set_name(id)
		new_entity_miniature_node.set_pic("res://DataBase/Mobs/"+id+"/"+id+".png")
		new_entity_miniature_node.set_label(one_mob.entity_name)
		self.add_child(new_entity_miniature_node)

func entity_choosed(mob_choosed) :
	get_tree().get_current_scene().load_mob(mob_choosed)
	get_parent().visible = false
	get_parent().get_parent().get_node('AddEntityContainer').reset()


func _on_MobCarrousel_value_changed(value):
	self.rect_position.x = (value-previous_value)*-10
	value = previous_value
	get_parent().get_parent().get_node('AddEntityContainer').reset()


func _on_Close_button_down():
	get_parent().visible = false

func reset() :
	for one_child in get_children() :
		one_child.queue_free()
