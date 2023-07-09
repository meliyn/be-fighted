extends Button


func _clicked():
	get_tree().change_scene_to_packed(preload("res://src/game.tscn"))
