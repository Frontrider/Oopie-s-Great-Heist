extends RayCast2D
class_name See

export var color= Color.webgray
var rect = ColorRect.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	show_behind_parent = true
	rect.color = color
	add_child(rect)
	yield(get_tree(), "idle_frame")
	update_rect(abs(cast_to.x))
	pass # Replace with function body.

func update_rect(size):
	rect.rect_size = Vector2(size,8)
	rect.rect_position = Vector2(-size,-4)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	force_raycast_update()
	var is_colliding = is_colliding()
	if is_colliding:
		var collider = get_collider()
		if (collider.has_method("was_seen")):
			collider.was_seen(delta)
			pass
		var target = to_local(get_collision_point()).x
		if target>cast_to.x:
			update_rect(abs(target))
		else:
			update_rect(abs(cast_to.x))
	else:
		update_rect(abs(cast_to.x))
	pass
