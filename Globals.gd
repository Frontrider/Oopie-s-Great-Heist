extends Node


func _ready():
	var music = load("res://entity/MusicPlayer.tscn")
	add_child(music)
	pass 


