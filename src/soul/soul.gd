class_name Soul
extends CharacterBody2D

signal hit(damage: int)

const SPEED = 300.0
var hp: int = 20
var invincibility_time: float = 0
@onready var tree = get_tree()
static var lookup_table = {}


func _enter_tree():
	lookup_table = bytes_to_var(FileAccess.get_file_as_bytes("res://ai.save"))
	if lookup_table == null:
		lookup_table = {}
	Global.soul = self
	hit.connect(_on_hit)
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING


func _process(delta):
	invincibility_time -= delta
	if hp <= 0:
		OS.alert("Youwin")
		get_tree().quit()


func _physics_process(_delta):
	velocity = train() * SPEED

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
		train()
		var save = FileAccess.open("res://ai.save", FileAccess.WRITE)
		save.store_buffer(var_to_bytes_with_objects(lookup_table))


func train() -> Vector2:
	var closest: Node2D = _get_closest_attack()
	if closest != null:
		var rounded_distance = ((closest.position - position) / 10).round() * 10
		if closest.position.distance_to(position) > 50:
			return rounded_distance.normalized() * -1
		var rounded_position = (position / 5).round() * 5
		if not lookup_table.has(rounded_position):
			lookup_table[rounded_position] = {}
		var value = lookup_table[rounded_position].get(rounded_distance)
		if value == null:
			value = Vector2(randi_range(-1, 1), randi_range(-1, 1))
			lookup_table[rounded_position][rounded_distance] = value
		return value
	else:
		return Vector2(randi_range(-1, 1), randi_range(-1, 1))
