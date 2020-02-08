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
	z_index = float(global_position.y)
	$Healthbar.max_value = float(max_hp)
	$Healthbar.value = float(hp)

func setup(values) :
	id = values.id
	entity_name = values.entity_name
	profile_pic_route = "res://DataBase/Mobs/"+id+"/"+id+".png"
	profile_pic = load(String(profile_pic_route))
	$Sprite.set_texture(profile_pic)
	hp = values.hp
	max_hp = values.max_hp
	attack = values.attack
	armor = values.armor
	weapon_id = values.weapon_id
	weapon_name = values.weapon_name
	weapon_kind = values.weapon_kind
	weapon_profile_pic = ""
	weapon_attack = values.weapon_attack
	strenght = values.strenght
	perception = values.perception
	agility = values.agility
	charisma = values.charisma
	luck = values.luck
	strife = values.strife
	exp_to_give = values.exp_to_give
	gritz = values.gritz

func attack(target, isu) :
	anim.play("AttackLeft")
	print("J'attaque !")
	if(isu) :
		target.get_hit(self, attack + weapon_attack)
	else:
		target.get_hit(self, attack)

func get_hit(attacker, damage) :
	print( "Je me fait toucher !")
	if(damage - armor > 0) : 
		var get_hit_anim = $Anim.get_animation("GetHit")
		var idx = get_hit_anim.find_track('Healthbar:value')
		get_hit_anim.track_set_key_value(idx, 0, hp)
		hp -= (damage - armor)
		get_hit_anim.track_set_key_value(idx, 1, hp)
		$Healthbar.value = hp
		anim.play("GetHit")
	else :
		anim.play("Protect")
	if(hp <= 0) :
		if(attacker.is_in_group("kid")) :
			attacker.earn_exp(exp_to_give)
		attacker.earn_gritz(gritz)
		$Healthbar.value = 0
		die()

func earn_gritz(gritz_earned) :
	gritz += gritz_earned

func die() :
	anim.play("Die")
	$DeathTimer.start()

func _on_Button_button_down():
	strife_scene.toggle_entity_focus(self)

func erase():
	strife_scene.erase_entity(self)

