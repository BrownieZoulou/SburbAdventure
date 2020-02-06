extends Position2D

var kidPositions
var mobPositions
var i1 = 0
var i2 = 0

export var h_separation = 80
export var v_separation = 70
export var v_separation_offset = 20

onready var C = get_node("/root/Constants")

export(PackedScene) var Position_node

func _ready():
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