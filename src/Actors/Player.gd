extends Actor
class_name Player

onready var zoom = Vector2(1.0,1.0)
var _debug
var _vehicle

func _ready():
	_debug = get_parent().get("DEBUG")

func _physics_process(delta):
	._physics_process(delta)
	var direction = get_direction()
	var is_jump_interrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0
	_velocity = calc_velocity(_velocity, direction, speed, is_jump_interrupted)

func _input(event):
	if event is InputEventMouseButton:
		if _debug and event.is_pressed():
			var camera = $"Camera2D"
			# zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				camera.zoom *= Vector2(1.1, 1.1)
			# zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				camera.zoom /= Vector2(1.1, 1.1)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right")-Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func _on_InteractableDetector_area_entered(area):
	print(area)

func _on_InteractableDetector_body_entered(body):
	if body.is_in_group("Enemies"):
		queue_free()

func get_position(): return position

func calc_velocity(
		linear_velocity: Vector2,
		direction,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var ret = linear_velocity
	ret.x = speed.x * direction.x
	if direction.y == -1.0:
		ret.y = speed.y * direction.y
	if is_jump_interrupted:
		ret.y /= 2
	return ret

func mount(v):
	_vehicle = v
	speed = _vehicle.speed()
	
