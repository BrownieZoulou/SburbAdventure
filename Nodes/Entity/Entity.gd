extends Node2D

onready var strife_scene = get_tree().get_current_scene()
onready var anim = $Anim

var id = "void"
var entity_name = "the void"
var profile_pic_route = ""
var profile_pic
var hp = 10
var max_hp = 10
var attack = 1
var armor = 1
var weapon_id = ""
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

func attack(target, is_strife_used) :
	anim.play("AttackLeft")
	if(is_strife_used) :
		target.GetHit(self, attack + weapon_attack)
	else:
		target.GetHit(self, attack)

func get_hit(attacker, damage) :
	if(damage - armor > 0) : 
		var get_hit_anim = $Anim.get_animation("GetHit")
		var idx = get_hit_anim.find_track('Healthbar:value')
		get_hit_anim.track_set_key_value(idx, 0, hp)
		hp -= (damage - armor)
		get_hit_anim.track_set_key_value(idx, 1, hp)
		$Healthbar.value = hp
		anim.play("GetHit")
	if(hp <= 0) :
		if(attacker.is_in_group("kid")) :
			attacker.earn_exp(exp_to_give)
		attacker.earn_gritz(gritz)
		$Healthbar.value = 0
		die()

func earn_gritz(gritz_earned) :
	gritz += gritz_earned

func die() :
	pass

func _on_Button_button_down():
	strife_scene.toggle_entity_focus(self)