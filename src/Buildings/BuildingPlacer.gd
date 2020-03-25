extends Sprite

class_name BuildingPlacer

onready var Mouse_Position: = Vector2.ZERO
onready var _player = $"/root/TestLevel/Player"
onready var _player_pos = _get_player_pos()
onready var _placed = false
var snap_to_grid
var _sprite 

func _ready():
	if not _sprite:
		print("ERROR: initialized without sprite. Setting to default sprite")
		set_sprite(preload("Rover Garage.tscn").instance(), null)

func init(sprite, add_resource_per_second):
	set_sprite(sprite, add_resource_per_second)
	_ready()

func set_sprite(sprite, args):
	_sprite = sprite
	_sprite.args(args)
	add_child(_sprite)

func _on_Interact_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print("Clicked")

func _calc_pos(player_pos: Vector2, mouse_pos: Vector2):
	var ret = mouse_pos
	ret = snap_to_grid.call_func(ret) if snap_to_grid else ret
	return ret

func _get_player_pos(): return _player.position if _player else Vector2.ZERO

func is_valid_place(): return _sprite.is_valid_place()

func place():
	_sprite.position = position+_sprite.get_texture().get_size()/2
	_sprite.place()
	_placed = true
	remove_child(_sprite)
	return _sprite

func _process(delta):
	if not _placed:
		Mouse_Position = get_global_mouse_position()
		_player_pos = _get_player_pos()
		position = _calc_pos(_player_pos, Mouse_Position)
		if is_valid_place(): _sprite.reset_shader()
		else: _sprite.shader_red()
