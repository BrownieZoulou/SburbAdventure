extends Control

var STRIFE = true
var STRIFELESS = false

func Toggle_visibility(is_entity_focused, entity_focused, is_admin_mode) :
	if(is_entity_focused) :
		$Name.text = String(entity_focused.get("entity_name"))
		$Healthbar.max_value = int(entity_focused.get("max_hp"))
		$Healthbar.value = int(entity_focused.get("hp"))
		if(is_admin_mode) :
			$HealthPoint.text = "HP: " + String(entity_focused.get("hp")) + "/" + String(entity_focused.get("max_hp"))
			$StatContainer/Attack.text = "Attack: "+String(entity_focused.get("attack"))
			$StatContainer/Armor.text = "Armor: "+String(entity_focused.get("armor"))
			$StatContainer/Strenght.text = "Strenght: "+String(entity_focused.get("strenght"))
			$StatContainer/Agility.text = "Agility: "+String(entity_focused.get("agility"))
			$StatContainer/Perception.text = "Perception: "+String(entity_focused.get("perception"))
			$StatContainer/Charisma.text = "Charisma: "+String(entity_focused.get("charisma"))
			$StatContainer/Luck.text = "Luck: "+String(entity_focused.get("luck"))
			$StatContainer/Strife.text = "Strife: "+String(entity_focused.get("strife"))
			if(String(entity_focused.get("weapon_kind")) != ""):
				$WeaponKind.text = String(entity_focused.get("weapon_kind"))
				$StrifeAttack.visible = true
				$WeaponName.text = String(entity_focused.get("weapon_name"))
				$WeaponAttack.text = "Attack: "+String(entity_focused.get("weapon_attack"))
				$WeaponAttack.visible = true
			else :
				$StrifeAttack.visible = false
				$WeaponName.text = "Aucune_arme"
				$WeaponAttack.visible = false
			$Level.visible=false
			$ExpToNextLevel.visible=false
			if(entity_focused.is_in_group("kid")):
				$Level.visible = true
				$ExpToNextLevel.visible = true
				$ExpToNextLevel.text = String(entity_focused.get("next_level_experience_needed")) + " Exp before level up"
				$Level.text = "LV: " + String(entity_focused.get("level"))
		else :
			$Level.visible = true
			$ExpToNextLevel.visible = true
			$HealthPoint.text = "HP: ???/???"
			$StatContainer/Attack.text = "Attack: ???"
			$StatContainer/Armor.text = "Armor: ???"
			$StatContainer/Strenght.text = "Strenght: ???"
			$StatContainer/Agility.text = "Agility: ???"
			$StatContainer/Perception.text = "Perception: ???"
			$StatContainer/Charisma.text = "Charisma: ???"
			$StatContainer/Luck.text = "Luck: ???"
			$StatContainer/Strife.text = "Strife: ???"
			$WeaponName.text = String(entity_focused.get("weapon_name"))
			$WeaponAttack.text = "Attack: ???"
			if(String(entity_focused.get("weapon_kind")) != ""):
				$WeaponKind.text = String(entity_focused.get("weapon_kind"))
				$StrifeAttack.visible = true
			else :
				$StrifeAttack.visible = false
			if(entity_focused.is_in_group("kid")) :
				$Level.text = "LV: " + String(entity_focused.get("level"))
		self.visible = true
	else :
		self.visible = false

func _on_Close_button_down():
	self.visible = false
	get_tree().get_current_scene().Toggle_entity_focus(self)

func _on_StrifeAttack_button_down():
	get_tree().get_current_scene().Prepare_attack(STRIFE)
	get_tree().get_current_scene().Toggle_entity_focus(self)
	print("prepare strife attack!")


func _on_StrifelessAttack_button_down():
	get_tree().get_current_scene().Prepare_attack(STRIFELESS)
	get_tree().get_current_scene().Toggle_entity_focus(self)
	print("prepare strifeless attack!")
