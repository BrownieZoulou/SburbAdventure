extends Control

onready var add_element_panel = get_tree().get_current_scene().find_node("AddElementPanel")

var WITH_MOB = false
var WITH_KID = true

func _on_AddElementBtn_button_down():
	self.visible = true

func hide() :
	self.visible = false

func _on_AddMobElement_button_down():
	hide()
	add_element_panel.open(WITH_MOB)


func _on_AddKidElement_button_down():
	hide()
	add_element_panel.open(WITH_KID)