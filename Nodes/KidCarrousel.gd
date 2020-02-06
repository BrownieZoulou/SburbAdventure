extends HBoxContainer

var previous_value = 0
export(PackedScene) var entity_miniature_node

func _ready():
	pass

func _on_KidCarrousel_value_changed(value):
	self.rect_position.x = (value-previous_value)*-10
	value = previous_value

func _on_AddKid_button_down():
	get_parent().visible = true
	var kid_dictionary = get_tree().get_current_scene().get_kid_dictionary()
	for one_kid in kid_dictionary :
		var new_entity_miniature_node = entity_miniature_node.instance()
		var id = String(one_kid.id)
		new_entity_miniature_node.set_name(id)
		new_entity_miniature_node.set_pic("res://DataBase/Kids/"+id+"/"+id+".png")
		new_entity_miniature_node.set_label(one_kid.entity_name)
		self.add_child(new_entity_miniature_node)

func entity_choosed(kid_choosed) :
	get_tree().get_current_scene().load_kid(kid_choosed)
	get_parent().visible = false
	get_parent().get_parent().get_node('AddEntityContainer').reset()
	reset()


func _on_Close_button_down():
	get_parent().visible = false
	reset()

func reset() :
	for one_child in get_children() :
		one_child.queue_free()
