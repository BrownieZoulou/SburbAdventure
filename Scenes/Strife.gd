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

func add_mob(mob_values):
	if(mobs.size()<C.MAX_MOB) :
		var new_mob = Entity_node.instance()
		var mob_pos_number = 0
		var i_is_valid = true
		for i in range(mobs.size()) :
			if(mobs[i] is String) :
				print("mobs position " +String(i)+" isn't valid")
				mob_pos_number = i
				i_is_valid = false
				break
			else :
				print("mobs position " +String(i)+" is valid")
				mob_pos_number += 1
		print("New Mob Number on " + String(mob_pos_number))
		var new_mob_position =  $PositionManager/MobPositions.get_child(mob_pos_number).global_position
		new_mob.setup(mob_values)
		if(!i_is_valid) :
			mobs[mob_pos_number] = new_mob
		else :
			mobs.insert(mob_pos_number, new_mob)
		new_mob.global_position = new_mob_position
		get_tree().get_root().add_child(new_mob)


func add_kid(kid_values):
	if(kids.size()<C.MAX_KID) :
		var new_kid = Kid_node.instance()
		var new_kid_position =  $PositionManager/KidPositions.get_child(kids.size()).global_position
		new_kid.setup(kid_values)
		kids.insert(kids.size(), new_kid)
		new_kid.global_position = new_kid_position
		get_tree().get_root().add_child(new_kid)

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
			add_kid(one_kid_in_dictionary)

func get_kid_dictionary() :
	return kid_dictionary

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
			add_mob(one_mob_in_dictionary)

func get_mob_dictionary() :
	return mob_dictionary

func erase_entity(entity_to_erase) :
	var list_to_check
	if(entity_to_erase.is_in_group("kid")) :
		list_to_check = kids
	else :
		list_to_check = mobs
	for i in range(list_to_check.size()) :
		print(String(i) + " of " + String(list_to_check.size()))
		if(list_to_check[i] == entity_to_erase) :
			print("erasing :" + entity_to_erase.name + "number " + String(i))
			#list_to_check.remove(list_to_check.find(entity_to_erase))
			list_to_check[i] = ""
			return