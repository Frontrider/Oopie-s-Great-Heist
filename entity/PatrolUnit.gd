extends PathFollow2D
class_name PatrolUnit

export var patrol_speed = 5.0



# Called when the node enters the scene tree for the first time.
func _ready():
	_turn(false)
	pass

func _turn(left):
	var tween = get_tree().create_tween() as SceneTreeTween
	get_child(0).facing_left = left
	if left:
		tween.tween_callback(self,"_turn",[false]).set_delay(patrol_speed)
		tween.tween_property(self, "unit_offset", 1.0, patrol_speed)
	else:
		tween.tween_callback(self,"_turn",[true]).set_delay(patrol_speed)
		tween.tween_property(self, "unit_offset", 0.0, patrol_speed)
	pass
