class_name Game
extends Node2D

const stick_scene = preload("res://src/attacks/stick/stick.tscn")
var current_weapon: Global.Weapon = Global.Weapon.stick
@onready var box: Box = $Box
@onready var camera: Camera2D = $Camera

var _next_attack = 3
var _attack_elasped = 0
var is_dodging = false
var camera_elasped = 0
var camera_original_position: Vector2
var hp: int = 100


func _ready():
	Global.game = self
	camera_original_position = camera.position


func _process(delta):
	if is_dodging:
		camera_elasped += delta
		if camera_elasped < 0.125:
			camera.position.x -= delta * 1000
		elif camera_elasped < 0.25:
			pass
		elif camera_elasped < 0.325:
			camera.position.x += delta * 1000
		else:
			camera.position = camera_original_position
			is_dodging = false
	_attack_elasped += delta
	if _attack_elasped >= _next_attack:
		Global.play_sound(preload("res://assets/attac2.wav"))
		if not is_dodging:
			Global.play_sound(preload("res://assets/atta.wav"))
			hp -= randi_range(10, 50)
		_attack_elasped = 0
		_next_attack = randi_range(5, 20)


func _input(event):
	if event.is_action_pressed("control_attack"):
		if not is_dodging:
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
