extends Node2D

export(PackedScene) var Entity_node
export(PackedScene) var Kid_node

var kids = [] #tableau de kids
var mobs = [] #tableau de mobs

var is_admin_mode = true
var is_entity_focused
var entity_focused
var attack_is_ongoing
var is_strife_on

var kid_dictionary = {}
var new_kid_name

func _ready() :
	load_kid_dictionary()

func _on_AddMob_button_down():
	if(mobs.size()<16) :
		var new_entity = Entity_node.instance()
		var new_entity_position =  $PositionManager/MobPositions.get_child(mobs.size()).global_position
		mobs.insert(mobs.size(), new_entity)
		new_entity.global_position = new_entity_position
		get_tree().get_root().add_child(new_entity)


func add_kid(kid_values):
	if(kids.size()<8) :
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
	print("preparing attack!")
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