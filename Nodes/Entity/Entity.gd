extends Node2D

onready var strife_scene = get_tree().get_current_scene()
onready var anim = $Anim

var entity_name = "the void"
var profile_pic = ""
var hp = 10
var max_hp = 10
var attack = 1
var armor = 1
var weapon_name = "void weapon"
var weapon_kind = "test"
var weapon_profile_pic = ""
var weapon_attack = 1
var strenght = 1
var perception = 1
var agility = 1
var charisma = 1
var luck = 1
var strife = 1
var exp_to_give = 1
var gritz = 1

func _ready():
	z_index = global_position.y
	$Healthbar.max_value = max_hp
	$Healthbar.value = hp

func Attack(target, is_strife_used) :
	anim.play("AttackLeft")
	if(is_strife_used) :
		target.GetHit(self, attack + weapon_attack)
	else:
		target.GetHit(self, attack)

func GetHit(attacker, damage) :
	if(damage - armor > 0) : hp -= (damage - armor)
	anim.play("GetHit")
	$Healthbar.value = hp
	if(hp <= 0) :
		if(attacker.is_in_group("kid")) :
			attacker.EarnExp(exp_to_give)
		attacker.EarnGritz(gritz)
		$Healthbar.value = 0
		Die()

func EarnGritz(gritz_earned) :
	gritz += gritz_earned

func Die() :
	pass

func _on_Button_button_down():
	strife_scene.Toggle_entity_focus(self)