extends CanvasLayer

export var next_level:PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	$"%Next".target = next_level
	pass # Replace with function body.

func show_game_over():
	get_tree().paused = true
	$GameOver.show()

func show_won():
	get_tree().paused = true
	$GameWon.show()
