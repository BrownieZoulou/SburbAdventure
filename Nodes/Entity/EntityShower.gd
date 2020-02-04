extends Control

func Toggle_visibility(is_entity_focused, entity_focused, is_admin_mode) :
	if(is_entity_focused) :
		if(is_admin_mode) :
			$Name.text = String(entity_focused.get("entity_name"))
			$HealthPoint.text = "HP: " + String(entity_focused.get("hp")) + "/" + String(entity_focused.get("max_hp"))
			$Healthbar.max_value = int(entity_focused.get("max_hp"))
			$Healthbar.value = int(entity_focused.get("hp"))
			$StatContainer/Attack.text = "Attack: "+String(entity_focused.get("attack"))
			$StatContainer/Armor.text = "Armor: "+String(entity_focused.get("armor"))
			$StatContainer/Strenght.text = "Strenght: "+String(entity_focused.get("strenght"))
			$StatContainer/Agility.text = "Agility: "+String(entity_focused.get("agility"))
			$StatContainer/Perception.text = "Perception: "+String(entity_focused.get("perception"))
			$StatContainer/Charisma.text = "Charisma: "+String(entity_focused.get("charisma"))
			$StatContainer/Luck.text = "Luck: "+String(entity_focused.get("luck"))
			$StatContainer/Strife.text = "Strife: "+String(entity_focused.get("strife"))
			$WeaponName.text = String(entity_focused.get("weapon_name"))
			$WeaponAttack.text = "Attack: "+String(entity_focused.get("weapon_attack"))
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
			$Name.text = String(entity_focused.get("entity_name"))
			$HealthPoint.text = "HP: ???/???"
			$Healthbar.max_value = int(entity_focused.get("max_hp"))
			$Healthbar.value = int(entity_focused.get("hp"))
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
			if(entity_focused.is_in_group("kid")) :
				$Level.text = "LV: " + String(entity_focused.get("level"))
		self.visible = true
	else :
		self.visible = false

func _on_Close_button_down():
	self.visible = false
	get_tree().get_current_scene().Toggle_entity_focus(self)


func _on_ChangeWeaponBtn_button_down():
	$ChangeWeaponBox.visible = true

func _on_ConfirmChange_button_down():
	$ChangeWeaponBox.visible = false
	if(String($ChangeWeaponBox/NewWeaponAttack/AttackChangeValue.text).to_int() is int) : 
		get_tree().get_current_scene().entity_focused.set("weapon_attack",$ChangeWeaponBox/NewWeaponAttack/AttackChangeValue.text)
	if(String($ChangeWeaponBox/NewWeaponName/NameChangeValue.text) != "") :
		get_tree().get_current_scene().entity_focused.set("weapon_name", $ChangeWeaponBox/NewWeaponName/NameChangeValue.text)
	$ChangeWeaponBox/NewWeaponAttack/AttackChangeValue.text = ""
	$ChangeWeaponBox/NewWeaponName/NameChangeValue.text = ""
	get_tree().get_current_scene().ReloadEntityShower()