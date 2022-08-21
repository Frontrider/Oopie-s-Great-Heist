tool 
extends GridContainer

export(PackedScene) var ButtonScene
export var level_count = 1 setget _set_level_count

func _set_level_count(new):
	level_count = new
	render()
	pass


func render():
	if not is_inside_tree():
		return
	for c in get_children():
		if is_instance_valid(c):
			c.queue_free()
	yield(get_tree(), "idle_frame")
	
	var index = 0
	for i in level_count:
		var button = ButtonScene.instance()
		button.name = str(i+1)
		call_deferred("add_child",button)
		pass
	pass


func _ready():
	render()
	pass


