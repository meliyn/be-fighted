extends Node

enum Weapon { stick }

var soul: Soul
var game: Game


func play_sound(stream: AudioStream):
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = stream
	audio_player.play()
	audio_player.finished.connect(func(): audio_player.queue_free())
