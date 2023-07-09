extends TextureProgressBar


func _process(_delta):
	value = Global.game.hp
	print(Global.game.hp)
