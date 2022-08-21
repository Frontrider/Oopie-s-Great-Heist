tool
extends Node2D

enum Type{
	ROPE,LADDER
}

const TEXTURES = {
	0:{
		"TOP": preload("res://assets/tiles/tile_0069.png"),
		"MIDDLE": preload("res://assets/tiles/tile_0089.png"),
		"BOTTOM": preload("res://assets/tiles/tile_0109.png")
	},
	1:{
		"TOP": preload("res://assets/tiles/tile_0051.png"),
		"MIDDLE": preload("res://assets/tiles/tile_0071.png"),
		"BOTTOM": preload("res://assets/tiles/tile_0071.png")
	}
}
const ClimbAreaScene = preload("res://entity/climbable/ClimbArea.tscn")

var top:Texture
var middle:Texture
var bottom:Texture

export var height = 1 setget _set_height
export(Type) var type =0 setget _set_type

func _set_height(new):
	if new <0:
		return
	height = new
	render()
	pass

func _set_type(new):
	type = new
	render()
	pass

func render():
	if not is_inside_tree():
		return
	for c in get_children():
		if is_instance_valid(c):
			c.queue_free()
	yield(get_tree(), "idle_frame")
	var bottom = TEXTURES[type].BOTTOM
	new_sprite(bottom)
	var mid = TEXTURES[type].MIDDLE
	for i in range(height):
		var y = -(i+1)*18
		new_sprite(mid, y)
		pass
	var y = -((height+1)*18)
	new_sprite(TEXTURES[type].TOP,y)
	pass

func new_sprite(tex:Texture,offset = 0):
	var sprite = Sprite.new()
	var climb_area = ClimbAreaScene.instance()
	sprite.texture = tex
	#Connect, so we can change the position when the node is in the tree.
	climb_area.connect("tree_entered",self,"_sprite_entered_tree",[climb_area,offset],CONNECT_ONESHOT)
	sprite.connect("tree_entered",self,"_sprite_entered_tree",[sprite,offset],CONNECT_ONESHOT)
	call_deferred("add_child",sprite)
	call_deferred("add_child",climb_area)

func _sprite_entered_tree(sprite,offset):
	sprite.position.y = offset
	pass

func _ready():
	render()
	pass
