extends Button

export(PackedScene) var target


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed",self,"on_pressed")
	pass # Replace with function body.

func on_pressed():
	get_tree().paused = false
	if target == null:
		get_tree().reload_current_scene()
	else:
		get_tree().change_scene_to(target)
	pass
