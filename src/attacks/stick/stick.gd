extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready():
	animation_player.play("poke")
	animation_player.animation_finished.connect(_on_finished)
	body_entered.connect(_on_entered)


func _on_finished(_name):
	self.queue_free()


func _on_entered(node: Node2D):
	if node == Global.soul:
		print("SOUl")
	pass
