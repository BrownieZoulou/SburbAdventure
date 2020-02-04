extends Node2D

export(PackedScene) var Entity_node

var kids = [] #tableau de kids
var mobs = [] #tableau de mobs

var is_admin_mode = true
var is_entity_focused
var entity_focused
var attack_is_ongoing

func _on_AddMob_button_down():
	if(mobs.size()<16) :
		var new_entity = Entity_node.instance()
		var new_entity_position =  $PositionManager/MobPositions.get_child(mobs.size()).global_position
		mobs.insert(mobs.size(), new_entity)
		new_entity.global_position = new_entity_position
		get_tree().get_root().add_child(new_entity)


func _on_AddKid_button_down():
	if(kids.size()<8) :
		var new_entity = Entity_node.instance()
		var new_entity_position =  $PositionManager/KidPositions.get_child(kids.size()).global_position
		kids.insert(kids.size(), new_entity)
		new_entity.global_position = new_entity_position
		get_tree().get_root().add_child(new_entity)

func Toggle_entity_focus(e) :
	if(entity_focused == e) :
		is_entity_focused = false
		entity_focused = null
	else : 
		entity_focused = e
		is_entity_focused = true
	$CanvasLayer/EntityShower.Toggle_visibility(is_entity_focused, entity_focused, is_admin_mode)
