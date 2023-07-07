extends Area2D

var time_elasped: float = 0


func _ready():
	body_entered.connect(_on_entered)


func _process(delta):
	time_elasped += delta
	if time_elasped < 0.2:
		position.y -= delta * 300
	elif time_elasped < 0.4:
		position.y += delta * 300
	else:
		_on_finished()


func _on_finished():
	self.queue_free()


func _on_entered(node: Node2D):
	if node == Global.soul:
		print("SOUl")
	pass
