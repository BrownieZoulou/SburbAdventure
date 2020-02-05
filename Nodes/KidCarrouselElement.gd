extends Control



func _on_Button_button_down():
	get_parent().kid_choosed(self.name)
