extends TextureRect

func _on_Delete_button_down():
	self.visible = true



func _on_Button_button_down():
	self.visible = false
	SetUpDeletion()

func SetUpDeletion() :
	pass

func _on_Button2_button_down():
	self.visible = false
