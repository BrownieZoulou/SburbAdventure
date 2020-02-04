extends "res://Nodes/Entity/Entity.gd"

var level = 0
var experience = 0
var next_level_experience_needed = 1
var echeladder = []

func EarnExp(exp_earned) :
	experience += exp_earned
	if(experience >= next_level_experience_needed) :
		level += 1
		experience -= next_level_experience_needed
		next_level_experience_needed +=1