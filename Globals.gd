extends Node


func _ready():
	var music = load("res://entity/MusicPlayer.tscn").instance() as AudioStreamPlayer
	music.playing = true
	add_child(music)
	pass
