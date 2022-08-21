tool
extends Node2D

export var facing_left = false setget _set_facing

func _set_facing(new):
	facing_left = new
	if facing_left:
		scale.x = -1
	else:
		scale.x = 1
	#$AnimatedSprite.flip_h = facing_left

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
