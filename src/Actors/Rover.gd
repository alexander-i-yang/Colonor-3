extends Vehicle
class_name Rover
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var _crystal_manager

func _ready():
	speed = Vector2(50, 10)
	print("Size: ", get_size())

func set_crystal_manager(man):
	_crystal_manager = man
	var closest_crystal_sprite = _crystal_manager.get_closest_crystal(get_parent().position)
	var target_pos = closest_crystal_sprite.position
	var crystal_width = closest_crystal_sprite.texture.get_size().x
	# Determine which side the rover should end up on
	if get_position().x > target_pos.x: target_pos.x += crystal_width
	else: target_pos.x -= crystal_width
	set_target_position(target_pos)

func get_position():
	return position+get_parent().position

func _physics_process(delta):
	._physics_process(delta)

func is_player_overlap():
	var bodies = $"PlayerPass".get_overlapping_bodies()
	var ret = false
	for body in bodies:
		if body.name == "Player":
			ret = true
			break
	return ret

func get_size():
	print("Width: ", $"ColorRect".get_parent_area_size())
	return $"ColorRect".get_parent_area_size()

func mount():
	var player = $"/root/Player"
	player.mount(self)
	visible = false
