extends TextureRect

func _on_Delete_button_down():
	self.visible = true



func _on_Button_button_down():
	self.visible = false
	get_parent().visible = false
	get_tree().get_current_scene().erase_focused_entity()

func _on_Button2_button_down():
	self.visible = false
