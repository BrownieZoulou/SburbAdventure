extends HBoxContainer

func _button_down():
	$AddKid.disabled = true
	$AddMob.disabled = true
	get_parent().get_node('Close').visible = true
	get_parent().get_node("EntityShower")._on_Close_button_down()

func reset() :
	$AddKid.disabled = false
	$AddMob.disabled = false
	get_parent().get_node('Close').visible = false

func _on_Close_button_down():
	reset()
