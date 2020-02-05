extends HBoxContainer

var previous_value = 0

func _on_KidCarrousel_value_changed(value):
	self.rect_position.x = (value-previous_value)*-10
	value = previous_value
	print(rect_position.x)


func _on_AddKid_button_down():
	get_parent().visible = true

func KidChoosed(kid_choosed) :
	get_tree().get_current_scene().LoadKid(kid_choosed)
	get_parent().visible = false
