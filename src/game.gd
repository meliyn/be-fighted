extends Node2D

const stick_scene = preload("res://src/attacks/stick/stick.tscn")
var current_weapon: Global.Weapon = Global.Weapon.stick


func _input(event):
	if event.is_action_pressed("control_attack"):
		match current_weapon:
			Global.Weapon.stick:
				_stick_attack()


func _stick_attack():
	var instance = stick_scene.instantiate()
	instance.position = get_global_mouse_position()
	add_child(instance)
