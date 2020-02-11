extends "res://Nodes/Entity/Entity.gd"

var level = 0
var experience = 0
var next_level_experience_needed = 1
var echeladder = []

func earn_exp(ee) :
	ee = float(ee)
	experience += ee
	if(experience >= next_level_experience_needed) :
		level += 1
		experience -= next_level_experience_needed
		next_level_experience_needed +=1

func attack(target, is_strife_used) :
	anim.play("AttackRight")
	if(is_strife_used) :
		target.get_hit(self, attack + weapon_attack)
	else:
		target.get_hit(self, attack)

func setup(values) :
	id = values.id
	entity_name = values.entity_name
	profile_pic_route = "res://DataBase/Kids/"+id+"/"+id+".png"
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
	level = values.level
	experience = values.experience
	next_level_experience_needed = values.next_level_experience_needed
	echeladder = []