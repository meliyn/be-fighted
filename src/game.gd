extends Node2D

const stick_scene = preload("res://src/attacks/stick/stick.tscn")
var current_weapon: Global.Weapon = Global.Weapon.stick
@onready var box: Box = $Box
@onready var camera: Camera2D = $Camera

var is_dodging = 0
var camera_elasped = 0
var camera_original_position: Vector2


func _ready():
	camera_original_position = camera.position


func _process(delta):
	if is_dodging:
		camera_elasped += delta
		if camera_elasped < 0.125:
			camera.position.x -= delta * 1000
		elif camera_elasped < 0.25:
			camera.position.x += delta * 1000
		else:
			camera.position = camera_original_position
			is_dodging = false


func _input(event):
	if event.is_action_pressed("control_attack"):
		match current_weapon:
			Global.Weapon.stick:
				_stick_attack()
	if event.is_action_pressed("control_dodge"):
		if not is_dodging:
			camera_elasped = 0
			is_dodging = true


func _stick_attack():
	var instance = stick_scene.instantiate()
	instance.position = get_global_mouse_position()
	add_child(instance)
