tool
extends Button

enum Mode{
	AVAILABLE,COMPLETED,LOCKED
}

export(StyleBox) var available
export(StyleBox) var available_pressed
export(StyleBox) var completed
export(StyleBox) var completed_pressed
export(StyleBox) var locked
export(StyleBox) var locked_pressed

export(Mode) var mode= 0 setget _set_mode

func _ready():
	text = name

func _set_mode(new):
	mode = new
	disabled = false
	if mode == Mode.AVAILABLE:
		_set_theme(available_pressed,available)
	if mode == Mode.COMPLETED:
		_set_theme(completed_pressed,completed)
	if mode == Mode.LOCKED:
		_set_theme(locked_pressed,locked)
		disabled = true
	pass

func _set_theme(press,normal):
	self.add_stylebox_override("normal",normal)
	self.add_stylebox_override("hover",press)
	self.add_stylebox_override("focus",press)
	self.add_stylebox_override("disabled",locked)
	pass


func _on_Button_pressed():
	get_tree().change_scene_to(load("res://levels/Level"+name+".tscn"))
	pass
