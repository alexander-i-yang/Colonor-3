extends KinematicBody2D
class_name Actor

const floor_normal = Vector2.UP

export var GRAVITY: = 200.0
var speed: = Vector2(100.0, 300.0)
onready var _velocity: = Vector2.ZERO

var has_target
var _target_position

func set_target_position(target: Vector2) -> void:
	print("target pos: ", target)
	set_has_target(true)
	_target_position = target
	print(_target_position)

func set_has_target(t):
	has_target = t
	if not t:
		_velocity = Vector2.ZERO
		_target_position = null

func _physcics_process(delta):
	_velocity.y += GRAVITY*delta
	if has_target:
		var dif = _target_position.x - position.x
		print(dif)
		if abs(dif) < 1.0:
			set_has_target(false)
		elif dif < 0: dif = -1
		else: dif = 1
		_velocity.x = dif*speed.x
	move_and_slide(_velocity, floor_normal)
