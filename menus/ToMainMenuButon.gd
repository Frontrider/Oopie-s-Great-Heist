extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed",self,"on_pressed")
	pass # Replace with function body.

func on_pressed():
	get_tree().change_scene_to(load("res://menus/MainMenu.tscn"))
	pass
