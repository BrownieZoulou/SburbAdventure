extends Control


func _on_Button_button_down():
	get_parent().entity_choosed(get_name())

func set_pic(route) :
	var profile_pic = ImageTexture.new()
	profile_pic.load(route)
	$Setting/ProfilePic.set_texture(profile_pic)

func set_label(name) :
	$Setting/Name.text = name