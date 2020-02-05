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

func _on_AddMob_button_down():
	if(mobs.size()<16) :
		var new_entity = Entity_node.instance()
		var new_entity_position =  $PositionManager/MobPositions.get_child(mobs.size()).global_position
		mobs.insert(mobs.size(), new_entity)
		new_entity.global_position = new_entity_position
		get_tree().get_root().add_child(new_entity)


func _on_AddKid_button_down():
	if(kids.size()<8) :
		var new_kid = Kid_node.instance()
		var new_kid_position =  $PositionManager/KidPositions.get_child(kids.size()).global_position
		kids.insert(kids.size(), new_kid)
		new_kid.global_position = new_kid_position
		get_tree().get_root().add_child(new_kid)

func Toggle_entity_focus(e) :
	if(entity_focused == e || e == $CanvasLayer/EntityShower) : #Hide entity shower if with click a second time or if we click the close button
		if(!attack_is_ongoing) :
			is_entity_focused = false
			entity_focused = null
		else : #Furthermore! If attack is ongoing, close entity shower but keep the entity in mind
			is_entity_focused = false
	else : #Focusing an other entity
		if(attack_is_ongoing) : #But if attack on going, launch the Attack !!
			entity_focused.Attack(e, is_strife_on)
			is_entity_focused = false
			entity_focused = null
			attack_is_ongoing = false
			$CanvasLayer/Choosetarget.visible = false
		else :
			entity_focused = e
			is_entity_focused = true
	ReloadEntityShower()

func ReloadEntityShower() :
	$CanvasLayer/EntityShower.Toggle_visibility(is_entity_focused, entity_focused, is_admin_mode)

func Toggle_admin_mode() :
	is_admin_mode = !is_admin_mode
	$CanvasLayer/BtnContainer/HBoxContainer/CheckBox.pressed = is_admin_mode
	ReloadEntityShower()

func Prepare_attack(iso):
	print("preparing attack!")
	attack_is_ongoing = true
	is_strife_on = iso
	$CanvasLayer/Choosetarget.visible = true