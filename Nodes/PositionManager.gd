extends HBoxContainer

var kidPositions
var mobPositions
var i1 = 0
var i2 = 0

var nb_separation_max = 10
var nb_separation_left = 0

export var h_separation = 60
export var v_separation = 60
export var v_separation_offset = 20

onready var C = get_node("/root/Constants")

export(PackedScene) var Position_node

var separation = 0
var separation_min = 900
var positionY = 710 

func _ready():
	self.rect_global_position.y = positionY
	self.set("custom_constants/separation", separation_min)
	nb_separation_left = nb_separation_max
	
	for i1 in range(C.MAX_KID) :
		var new_kid_position = Position_node.instance()
		new_kid_position.get_child(1).text = String(i1)
		$KidPositions.add_child(new_kid_position)
		$KidPositions.get_child(i1).position.x += (h_separation*((i1%4) + (int(i1/4))))
		$KidPositions.get_child(i1).position.y += (-v_separation*(i1%4) + (int(i1/4)*v_separation_offset))
	
	
	for i2 in range(C.MAX_MOB) :
		var new_mob_position = Position_node.instance()
		new_mob_position.get_child(1).text = String(i2)
		$MobPositions.add_child(new_mob_position)
		$MobPositions.get_child(i2).position.x += (-h_separation*((i2%4) + (int(i2/4))))
		$MobPositions.get_child(i2).position.y += (-v_separation*(i2%4) + (int(i2/4)*v_separation_offset))

func separate(isk) :
	print("modifictaion !")
	if(nb_separation_left > 0) :
		separation += 50
		self.set("custom_constants/separation", separation)
		get_tree().get_current_scene().reload_entity_position(isk)
		nb_separation_left -= 1

func get_closer(isk) :
	if(nb_separation_left < nb_separation_max) :
		separation -= 50
		self.set("custom_constants/separation", separation)
		get_tree().get_current_scene().reload_entity_position(isk)
		nb_separation_left += 1