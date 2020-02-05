extends Control

func _on_ChangeWeaponBtn_button_down():
	self.visible = true
	$NewWeaponAttack/AttackChangeValue.set_text(String(get_tree().get_current_scene().entity_focused.get("weapon_attack")))
	$NewWeaponKind/KindChangeValue.set_text(get_tree().get_current_scene().entity_focused.get("weapon_kind"))
	$NewWeaponName/NameChangeValue.set_text(get_tree().get_current_scene().entity_focused.get("weapon_name"))

func _on_ConfirmChange_button_down():
	self.visible = false
	if(String($NewWeaponAttack/AttackChangeValue.text).to_int() is int) : 
		get_tree().get_current_scene().entity_focused.set("weapon_attack",int($NewWeaponAttack/AttackChangeValue.get_text().to_int()))
	if(String($NewWeaponKind/KindChangeValue.text) != "") : 
		get_tree().get_current_scene().entity_focused.set("weapon_kind",$NewWeaponKind/KindChangeValue.get_text())
	if(String($NewWeaponName/NameChangeValue.text) != "") :
		get_tree().get_current_scene().entity_focused.set("weapon_name", $NewWeaponName/NameChangeValue.get_text())
	$NewWeaponAttack/AttackChangeValue.set_text("")
	$NewWeaponName/NameChangeValue.set_text("")
	$NewWeaponKind/KindChangeValue.set_text("")
	get_tree().get_current_scene().reload_entity_shower()