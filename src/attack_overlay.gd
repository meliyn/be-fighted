extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	play()
	animation_finished.connect(_on_finished)


func _on_finished():
	self.queue_free()
