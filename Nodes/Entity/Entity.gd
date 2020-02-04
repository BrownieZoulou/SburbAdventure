extends Node2D

onready var strife_scene = get_tree().get_current_scene()

var entity_name = "the void"
var profile_pic = ""
var hp = 1
var attack = 1
var armor = 1
var weapon = "void weapon"
var weapon_profile_pic = ""
var weapon_attack = 1
var strengh = 1
var perception = 1
var agility = 1
var charisma = 1
var luck = 1
var strife = 1

func _ready():
	z_index = global_position.y

func Attack(target) :
	target.GetHit(attack)

func AttackWithWeapon(target) :
	target.GetHit(attack + weapon_attack)

func GetHit(damage) :
	if(damage - armor > 0) : hp -= (damage - armor)

func _on_Button_button_down():
	strife_scene.Toggle_entity_focus(self)
