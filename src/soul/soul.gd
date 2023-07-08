class_name Soul
extends CharacterBody2D

const SPEED = 300.0
var vector: Vector2
@onready var tree = get_tree()


func _enter_tree():
	Global.soul = self


func _ready():
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING


func _physics_process(_delta):
	var closest: Node2D = _get_closest_attack()
	if closest != null:
		var original_rotation = rotation
		look_at(closest.position)
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
