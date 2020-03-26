extends Building

class_name Rover_Garage

var _debug = false

func _ready(): if _debug: spawn_rover()

var crystal_manager

func place():
	spawn_rover()

func spawn_rover():
	# Create a new rover
	var new_rover = load("res://src/Actors/Rover.tscn").instance()
	# Position the rover
	var rover_pos = texture.get_size()
	rover_pos.x *= 1.5
	rover_pos.y -= new_rover.get_node("ColorRect").get_size().y
	new_rover.position = rover_pos
	# Set the rover's crystal manager
	add_child(new_rover)
	new_rover.set_crystal_manager(crystal_manager)
