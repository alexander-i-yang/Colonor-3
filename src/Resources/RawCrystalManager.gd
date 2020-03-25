extends Node2D

# For sorting purposes. Try to remove later.
var crystal_coord_helper = Vector2.ZERO

func _ready():
	randomize()

func _make_crystal_sprite():
	return load("res://src/Resources/RawCrystal.tscn").instance()

func get_raw_crystals_pos(
	tile_size: Vector2, # Size of one tile
	grid_size: Vector2, # Size of the UI Grid
	map_tiles: Array,
	start_tile_pos: Vector2 # Top left corner of first tile
	):
	var total_crystals = 5
	var c_per_tile = 1
	# Get a random list of tiles to put the crystal on. All unique.
	# Each tile has an equal chance of getting a crystal.
	map_tiles.shuffle()
	var ret = []
	var index = 0
	var raw_crystal_height = 40# _make_crystal_sprite().texture.get_size().y
	while total_crystals > 0:
		# Set the current crystal position to the top left corner of the current tile
		var cur_crystal_pos = Vector2(map_tiles[index][0] * tile_size.x, start_tile_pos.y)
		for i in c_per_tile:
			if total_crystals > 0:
				# Increment the current crystal pos by a random number between
				# the end and start bounds of the tile
				cur_crystal_pos.x += randi() % int(tile_size.x-grid_size.x)
				# snap the crystal position to the grid
				cur_crystal_pos = cur_crystal_pos.snapped(grid_size)
				# Account for the height of the crystal
				cur_crystal_pos.y -= raw_crystal_height/2
				ret.append(cur_crystal_pos)
				total_crystals -= 1
		index += 1
	return ret

func set_raw_crystal_poss(poss):
	for pos in poss:
		var raw_crystal = _make_crystal_sprite()
		raw_crystal.position = pos
		add_child(raw_crystal)
		print(raw_crystal.position)

func get_closest_crystal(pos):
	var children = []
	for i in get_children():
		children.append(i)
	children.sort_custom(self, "sort_ascending")
	return children[0]

func sort_ascending(a, b):
	return a.position-crystal_coord_helper < b.position-crystal_coord_helper
