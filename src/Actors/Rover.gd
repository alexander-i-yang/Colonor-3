extends Actor

class_name Rover
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var _crystal_manager

func _ready():
	speed = Vector2(50, 10)
	set_friction(0.8)

func set_crystal_manager(man):
	_crystal_manager = man
	var closest_crystal_sprite = _crystal_manager.get_closest_crystal(position)
	print(closest_crystal_sprite.position)
	set_target_position(_crystal_manager.position-closest_crystal_sprite.position)

func _physics_process(delta):
	._physcics_process(delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
