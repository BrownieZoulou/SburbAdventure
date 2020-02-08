extends Control

var is_it_kid

var dictionary_to_save= {}

var new_id
var new_entity_name
var new_profile_pic_route
var new_profile_pic
var new_hp
var new_max_hp
var new_attack
var new_armor
var new_weapon_id
var new_weapon_name
var new_weapon_kind
var new_weapon_profile_pic
var new_weapon_attack
var new_strenght
var new_perception
var new_agility
var new_charisma
var new_luck
var new_strife
var new_exp_to_give
var new_gritz

var new_level
var new_experience
var new_next_level_experience_needed
var new_echeladder

var path_new_img

func open(isk) :
	self.visible = true
	is_it_kid = isk
	if(is_it_kid) :
		$KidValue.visible = true
	else :
		$KidValue.visible = false
	

func hide():
	self.visible = false


func _on_CreateElement_button_down():
	var success = true
	var error = ""
	
	for one_child in self.get_children() :
		if(one_child.is_in_group("entityValue") || one_child.is_in_group("kidValue") && is_it_kid) :
			for one_value in one_child.get_children() :
				var one_text_edit = one_value.get_child(1)
				if(one_text_edit.get_text() == "" || one_text_edit.get_text() == null) :
					success = false
					error += String(one_text_edit.get_parent().get("name")) + " value not Set ! **"
				else :
					var value_path
					value_path = "new_"+String(one_value.name)
					if(one_value.is_in_group("string")) :
						self.set(value_path, one_text_edit.get_text())
						dictionary_to_save[one_value.name] = one_text_edit.get_text()
					else :
						if(!one_text_edit.text.is_valid_integer()):
							error += one_text_edit.get_parent().name +" value is wrong ! Set an Int ! ** "
							success = false
						else : 
							self.set(value_path, int(one_text_edit.get_text()))
							dictionary_to_save[one_value.name] = one_text_edit.get_text()
	
	var img = Image.new()
	if(img.load(path_new_img) != 0) :
		success = false
		error += " Couldn't load png file !! **"
	
	if (success) :
		hide()
		save_entity()
	else:
		$ErrorDisplayer.set_text(error)

func save_entity() :
	var save_element = File.new()
	var save_route = ""
	var loaded_dictionary
	if(is_it_kid) :
		save_route = "res://Database/Kids/KidsBDD.save"
		loaded_dictionary = get_tree().get_current_scene().get_kid_dictionary()
	else :
		save_route = "res://Database/Mobs/MobsBDD.save"
		loaded_dictionary = get_tree().get_current_scene().get_kid_dictionary()
	var d = []
	d.append(dictionary_to_save)
	dictionary_to_save = loaded_dictionary + d
	var json_dictionary = {}
	json_dictionary["json"] = dictionary_to_save
	var json_file = to_json(json_dictionary)
	save_element.open(save_route, File.WRITE)
	save_element.store_line(json_file)
	save_element.close()
	if(is_it_kid) :
		get_tree().get_current_scene().set_kid_dictionary(dictionary_to_save)
	else :
		get_tree().get_current_scene().set_mob_dictionary(dictionary_to_save)
	
	var img = Image.new()
	img.load(path_new_img)
	var dir_path = "res://DataBase/"
	if(is_it_kid) :
		dir_path += "Kids/"
	else :
		dir_path += "Mobs/"
	var dir = Directory.new()
	dir.open(dir_path)
	dir.make_dir(String(new_id))
	img.save_png(dir_path+new_id+"/"+new_id+".png")


func _on_SpriteButton_button_down():
	$FileDialog.popup()


func _on_FileDialog_file_selected(path):
	path_new_img = path
	$SpriteValue/TextEdit.set_text(path)