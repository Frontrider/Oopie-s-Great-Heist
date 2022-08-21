extends Area2D

signal marked(delta)

func mark(delta):
	emit_signal("marked",delta)
	pass
