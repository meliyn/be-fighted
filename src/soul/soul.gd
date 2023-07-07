class_name Soul
extends CharacterBody2D

const SPEED = 300.0


func _enter_tree():
	Global.soul = self


func _ready():
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING


func _physics_process(_delta):
	# velocity.x = SPEED

	move_and_slide()
