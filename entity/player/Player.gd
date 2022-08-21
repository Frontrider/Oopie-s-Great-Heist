extends KinematicBody2D

signal seen

export var speed =5.0
export var gravity = 2.0
export var jump_force = 100.0
export var seen_multiplier = 10.0
export var max_seen = 100

var input = Vector2(0,0)
var sideways_speed = 0
var vertical_motion = 0
#Used for ladders
var climbing = []
var hiding_in = []
var seen = 0

onready var animation_player = $Node2D/AnimationPlayer
onready var seen_bar = $CanvasLayer/Node2D/ProgressBar
func _ready():
	$FailedOverlay/Node2D/Sprite.scale.x =0
	seen_bar.max_value = max_seen
	pass

func _process(delta):
	input.x = convert_sideways_motion(Input.is_action_pressed("ui_left"),Input.is_action_pressed("ui_right"))
	input.y = convert_sideways_motion(Input.is_action_pressed("ui_up"),Input.is_action_pressed("ui_down"))
	
	if Input.is_action_just_pressed("ui_select") and is_on_wall():
		vertical_motion -= jump_force
	if Input.is_action_pressed("ui_home"):
		for node in hiding_in:
			if node.has_method("mark"):
				node.mark(delta)
			pass
		pass

	pass

	pass

func convert_sideways_motion(left,right):
	if left:
		return -1
	elif right:
		return 1
	else:
		return 0
	pass

func was_seen(value):
	seen += value*seen_multiplier
	seen_bar.value = seen
	if seen >= max_seen:
		$AnimationPlayer.play("get_beamed")
		get_tree().paused = true
		emit_signal("seen")

func _physics_process(delta):
	#Animation
	if input.x ==0:
		animation_player.play("idle")
	else:
		animation_player.play("moving")
		$Node2D/AnimatedSprite.flip_h = sign(input.x) != -1
	
	sideways_speed= speed*input.x
	if climbing.empty():
		vertical_motion+= gravity
		if vertical_motion>= gravity*3:
			vertical_motion =gravity
	else:
		vertical_motion = speed*input.y
	move_and_slide(Vector2(sideways_speed,vertical_motion))
	
	if Input.is_action_pressed("ui_home"):
		set_collision_layer_bit(3,true)
	else:
		if hiding_in.empty():
			set_collision_layer_bit(3,true)
		else:
			set_collision_layer_bit(3,false)
	pass

func _unhandled_input(event):
	
	pass

func _on_ClimbSensor_area_entered(area):
	if not climbing.has(area):
		climbing.append(area)
	pass # Replace with function body.

func _on_ClimbSensor_area_exited(area):
	if climbing.has(area):
		climbing.erase(area)
	pass # Replace with function body.

func _on_HideSensor_area_entered(area):
	if not hiding_in.has(area):
		hiding_in.append(area)
		pass
	pass

func _on_HideSensor_area_exited(area):
	hiding_in.erase(area)
	pass
