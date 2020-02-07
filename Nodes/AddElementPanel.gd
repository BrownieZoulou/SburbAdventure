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
							error += one_text_edit.get_parent().name +" value is wrong ! Set an Int !** "
							success = false
						else : 
							self.set(value_path, int(one_text_edit.get_text()))
							dictionary_to_save[one_value.name] = one_text_edit.get_text()
	
	if (success) :
		hide()
		save_entity()
	else:
		$ErrorDisplayer.set_text(error)

func save_entity() :
	print("success!!!")
	print(String(dictionary_to_save))
	var save_element = File.new()
	var save_route = ""
	if(is_it_kid) :
		save_route = "res://Database/Kids/KidsBDD.save"
	else :
		save_route = "res://Database/Mobs/MobsBDD.save"
	save_element.open(save_route, File.WRITE)
	save_element.store_line(to_json(dictionary_to_save))
	save_element.close()