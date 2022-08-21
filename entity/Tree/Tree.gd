extends Node2D

signal marked

export var max_progress = 100.0
export var mark_multiplier = 10.0
export(NodePath) onready var tree = get_node(tree) as Node2D
var mark_progress = 0

onready var progress = $ProgressBar
onready var beam = $CanvasLayer/Node2D/Beam
onready var marking_audio = $AudioStreamPlayer2D
var taken = false

func _ready():
	progress.visible = true
	progress.max_value = max_progress
	pass

func _on_marked(delta):
	if not marking_audio.playing:
		marking_audio.play()
	pass 

func beam_out():
	progress.hide()
	var tween = get_tree().create_tween()
	tween.set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	tween.parallel().tween_property(tree,"rotation",PI/4,.5)
	tween.parallel().tween_property(beam,"scale",Vector2(1,600),1.5)
	tween.parallel().tween_property(tree,"position",tree.position-Vector2(0,200),2)
	tween.parallel().tween_property(beam,"scale",Vector2(0,600),.5).set_delay(1.5)
	marking_audio.stop()
	$CanvasLayer/Node2D/BeamSound.play()
	tween.parallel().tween_callback(self,"beamed_out").set_delay(2)
	pass
	
func beamed_out():
	queue_free()

func _process(delta):
	if marking_audio.playing:
		mark_progress += delta*mark_multiplier
		progress.value = mark_progress
		if mark_progress >= max_progress and not taken:
			taken = true
			emit_signal("marked")
			beam_out()
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "beam_out":
		queue_free()
	pass # Replace with function body.
