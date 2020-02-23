extends "res://Nodes/Entity/Entity.gd"

var level = 0
var experience = 0
var next_level_experience_needed = 1
var echeladder = []

var real_strenght
var real_perception
var real_agility
var real_charisma

var real_luck
var coef_strenght
var coef_perception
var coef_agility
var coef_charisma
var coef_luck

func level_up() :
	$Anim.play("LevelUp")
	level = float(level)+ 1
	next_level_experience_needed = (cos(level*0.5)+level)*26
	max_hp = float(max_hp) + 20
	hp = float(hp) + 20
	exp_to_give = floor((cos((level-1)*0.5)+(level-1))*26)
	
	real_strenght = float(real_strenght) + float(coef_strenght)
	strenght = floor(real_strenght)
	
	real_perception = float(real_perception) + float(coef_perception)
	perception = floor(real_perception)
	
	real_agility = float(real_agility) + float(coef_agility)
	agility = floor(real_agility)
	
	real_luck = float(real_luck) + float(coef_luck)
	luck = floor(real_luck)
	
	real_charisma = float(real_charisma) + float(coef_charisma)
	charisma = floor(real_charisma)

func earn_exp(ee) :
	ee = float(ee)
	next_level_experience_needed = float(next_level_experience_needed) - ee
	experience = float(experience) + ee
	if(float(next_level_experience_needed) <= 0) :
		level_up()

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
	
	coef_strenght = values.coef_strenght
	coef_perception = values.coef_perception
	coef_agility = values.coef_agility
	coef_charisma = values.coef_charisma
	coef_luck = values.coef_luck
	
	real_strenght = strenght
	real_perception = perception
	real_agility = agility
	real_charisma = charisma
	real_luck = luck
	
	strife = values.strife
	
	exp_to_give = values.exp_to_give
	gritz = values.gritz
	level = values.level
	experience = values.experience
	next_level_experience_needed = values.next_level_experience_needed
	echeladder = []