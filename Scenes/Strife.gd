extends Node2D

onready var C = get_node("/root/Constants")

export(PackedScene) var Entity_node
export(PackedScene) var Kid_node

var kids = [] #tableau de kids sur le terrain
var mobs = [] #tableau de mobs sur le terrain

var is_admin_mode = true
var is_entity_focused
var entity_focused
var attack_is_ongoing
var is_strife_on

var kid_dictionary = {}

var mob_dictionary = {}

func _ready() :
	load_kid_dictionary()
	load_mob_dictionary()

func add_entity(entity_value, is_it_kid) :
	var list_to_check
	var new_entity
	var new_entity_position_manager 
	var max_entity
	if(is_it_kid) :
		list_to_check = kids
		new_entity = Kid_node.instance()
		new_entity_position_manager =  $CanvasLayer/PositionManager/KidPositions
		max_entity = C.MAX_KID
	else :
		list_to_check = mobs
		new_entity = Entity_node.instance()
		new_entity_position_manager = $CanvasLayer/PositionManager/MobPositions
		max_entity = C.MAX_MOB
	if(list_to_check.size()<max_entity) :
		var entity_pos_number = 0
		var i_is_valid = true
		for i in range(list_to_check.size()) :
			if(list_to_check[i] == null) :
				entity_pos_number = i
				i_is_valid = false
				break
			else :
				entity_pos_number += 1
		var new_entity_position =  new_entity_position_manager.get_child(entity_pos_number).global_position
		new_entity.setup(entity_value)
		if(!i_is_valid) :
			list_to_check[entity_pos_number] = new_entity
		else :
			list_to_check.insert(entity_pos_number, new_entity)
		new_entity.global_position = new_entity_position
		get_tree().get_root().add_child(new_entity)
	print( int(( list_to_check.size() ) % 4) )
	#if (int((list_to_check.size() ) % 4) == 0) :
	#	$CanvasLayer/PositionManager.separate(is_it_kid)

func toggle_entity_focus(e) :
	if(entity_focused == e || e == $CanvasLayer/EntityShower) : #Hide entity shower if with click a second time or if we click the close button
		if(!attack_is_ongoing) :
			is_entity_focused = false
			entity_focused = null
		else : #Furthermore! If attack is ongoing, close entity shower but keep the entity in mind
			is_entity_focused = false
	else : #Focusing an other entity
		if(attack_is_ongoing) : #But if attack on going, launch the Attack !!
			entity_focused.attack(e, is_strife_on)
			is_entity_focused = false
			entity_focused = null
			attack_is_ongoing = false
			$CanvasLayer/ChooseTarget.visible = false
		else :
			entity_focused = e
			is_entity_focused = true
	reload_entity_shower()

func reload_entity_shower() :
	$CanvasLayer/EntityShower.Toggle_visibility(is_entity_focused, entity_focused, is_admin_mode)

func toggle_admin_mode() :
	is_admin_mode = !is_admin_mode
	$CanvasLayer/BtnContainer/HBoxContainer/CheckBox.pressed = is_admin_mode
	reload_entity_shower()

func prepare_attack(iso):
	attack_is_ongoing = true
	is_strife_on = iso
	$CanvasLayer/ChooseTarget.visible = true

func load_kid_dictionary()  :
	var new_kid_file = File.new()
	if not new_kid_file.file_exists("res://DataBase/Kids/KidsBDD.save"):
		print( "Error! We don't have a save to load.")
	else :
		new_kid_file.open("res://DataBase/Kids/KidsBDD.save", File.READ)
		var json_text = new_kid_file.get_as_text()
		kid_dictionary = JSON.parse(json_text).result.json
		new_kid_file.close()

func load_kid(kid_to_spawn) :
	for one_kid_in_dictionary in kid_dictionary :
		if(kid_to_spawn == one_kid_in_dictionary.id) :
			add_entity(one_kid_in_dictionary, true)

func get_kid_dictionary() :
	return kid_dictionary

func set_kid_dictionary(new_kid_dic) :
	kid_dictionary = new_kid_dic

func load_mob_dictionary()  :
	var new_mob_file = File.new()
	if not new_mob_file.file_exists("res://DataBase/Mobs/MobsBDD.save"):
		print( "Error! We don't have a save to load.")
	else :
		new_mob_file.open("res://DataBase/Mobs/MobsBDD.save", File.READ)
		var json_text = new_mob_file.get_as_text()
		mob_dictionary = JSON.parse(json_text).result.json
		new_mob_file.close()

func load_mob(mob_to_spawn) :
	for one_mob_in_dictionary in mob_dictionary :
		if(mob_to_spawn == one_mob_in_dictionary.id) :
			add_entity(one_mob_in_dictionary, false)

func get_mob_dictionary() :
	return mob_dictionary

func set_mob_dictionary(new_mob_dic) :
	mob_dictionary = new_mob_dic

func erase_entity(entity_to_erase) :
	var list_to_check
	var is_it_kid
	if(entity_to_erase.is_in_group("kid")) :
		list_to_check = kids
		is_it_kid = true
	else :
		list_to_check = mobs
		is_it_kid = false
	for i in range(list_to_check.size()) :
		if(list_to_check[i] == entity_to_erase) :
			list_to_check[i] = null
	#if (int(list_to_check.size())%4 == 0) :
	#	$CanvasLayer/PositionManager.get_closer(is_it_kid)

func reload_entity_position(isk) :
	var list_to_reload
	var position_to_reload
	if(isk):
		list_to_reload = kids
		position_to_reload = $CanvasLayer/PositionManager/KidPositions
	else :
		list_to_reload = mobs
		position_to_reload = $CanvasLayer/PositionManager/MobPositions
	for i in range(list_to_reload.size()) :
		print("test !!")
		list_to_reload[i].global_position = position_to_reload.get_child(i).global_position