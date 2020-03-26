extends KinematicBody2D
class_name Actor

const floor_normal = Vector2.UP

export var GRAVITY: = Vector2(0.0, 200.0)
var speed: = Vector2(100.0, 300.0)
onready var _velocity: = Vector2.ZERO

var has_target
var _target_position

func get_position(): return position

func set_target_position(target: Vector2) -> void:
	set_has_target(true)
	_target_position = target

func set_has_target(t):
	has_target = t
	if not t:
		_target_position = null
		_velocity.x = 0

func _physics_process(delta):
	_velocity.y += GRAVITY.y*delta
	var stop_moving = false
	if has_target:
		var dif = _target_position.x - get_position().x
		if abs(dif) < 1: stop_moving = true
		if dif < 0: dif = -1
		else: dif = 1
		_velocity.x = dif*speed.x
	move_and_slide(_velocity, floor_normal)
	if stop_moving: set_has_target(false)
