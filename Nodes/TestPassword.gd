extends TextureRect

onready var C = get_node("/root/Constants")

func setup_toggle() :
	if(get_tree().get_current_scene().is_admin_mode):
		get_tree().get_current_scene().toggle_admin_mode()
	else:
		self.visible = true

func test_password() :
	if(C.ADMIN_PASSWORD == $TextEdit.text) :
		get_tree().get_current_scene().toggle_admin_mode()
		self.visible = false
		$TextEdit.text = ""
	else :
		$TextEdit.text = "WRONG !"

func _on_Close_button_down():
	self.visible = false
	$TextEdit.text = ""
