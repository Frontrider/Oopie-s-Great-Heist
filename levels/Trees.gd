extends Node2D

onready var original_tree_count = get_child_count()
onready var tree_count = original_tree_count
signal trees_gone
func _ready():
	
	for tree in get_children():
		tree.connect("marked",self,"tree_taken",[tree])
	pass

func tree_taken(tree):
	tree_count-=1
	print("trees left: "+str(tree_count))
	if tree_count == 0:
		print("won")
		emit_signal("trees_gone")
	pass
