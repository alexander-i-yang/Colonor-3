class_name Vehicle
extends Actor

var _control
var _tooltip

func _ready():
	var control = Control.new()
	_control = control
	_tooltip = Label.new()
	_tooltip.set_align(HALIGN_CENTER)
	_tooltip.text = "Press space"
	_tooltip.visible = false
	control.add_child(_tooltip)
	add_child(control)

func _show_tooltip():
	print("C: ", _control.rect_position)
	print("T:", _tooltip.rect_position)
	_control.rect_position = Vector2(-40.0, -40.0)
	_tooltip.visible = true

func _hide_tooltip(): _tooltip.visible = false

func _on_PlayerPass_body_exited(body):
	if body.name == "Player":
		_hide_tooltip()

func _on_PlayerPass_body_entered(body):
	if body.name == "Player":
		_show_tooltip()
