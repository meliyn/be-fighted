class_name Soul
extends CharacterBody2D

signal hit(damage: int)

const SPEED = 300.0
var hp: int = 20
var invincibility_time: float = 0
@onready var tree = get_tree()
var _direction: Vector2


func _enter_tree():
	Global.soul = self
	hit.connect(_on_hit)
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING


func _process(delta):
	invincibility_time -= delta
	if hp <= 0:
		OS.alert("Youwin")
		get_tree().quit()


func _physics_process(_delta):
	var closest: Node2D = _get_closest_attack()
	if closest != null and position.distance_to(closest.position) < 150:
		var __direction = (position - closest.position).normalized()
		if _direction.distance_to(__direction) < 0.01:
			_direction = __direction * -1
		else:
			_direction = __direction
		velocity = _direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()


func _get_closest_attack() -> Node2D:
	var closest: Node2D
	var closest_distance: float = -1
	for attack in tree.get_nodes_in_group("attack"):
		var distance = position.distance_to(attack.position)
		if closest_distance == -1 or distance < closest_distance:
			closest = attack
			closest_distance = distance
	return closest


func _on_hit(damage: int):
	if invincibility_time <= 0:
		Global.play_sound(preload("res://assets/hurt.wav"))
		hp -= damage
		invincibility_time = 0.5
