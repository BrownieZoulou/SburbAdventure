extends Control

func Toggle_visibility(is_entity_focused, entity_focused, is_admin_mode) :
	if(is_entity_focused) :
		if(is_admin_mode) :
			$Name.text = String(entity_focused.get("entity_name"))
		else :
			pass
		self.visible = true
	else :
		self.visible = false

func _on_Close_button_down():
	self.visible = false
