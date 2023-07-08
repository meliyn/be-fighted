class_name Soul
extends CharacterBody2D

const SPEED = 300.0
var vector: Vector2
@onready var tree = get_tree()
var direction: Vector2


func _enter_tree():
	Global.soul = self


func _ready():
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING


func _physics_process(_delta):
	var closest: Node2D = _get_closest_attack()
	if closest != null and position.distance_to(closest.position) < 150:
		var _direction = (position - closest.position).normalized()
		print(_direction.distance_to(direction))
		if _direction.distance_to(direction) < 0.01:
			direction = _direction * -1
		else:
			direction = _direction
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	# velocity.x = SPEED

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
