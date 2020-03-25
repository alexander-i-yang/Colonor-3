extends Node2D

var _ui_background
var _ui_grid
onready var resource_manager = $"Control/ResourceManager"
onready var raw_crystal_manager = $"RawCrystalManager"

onready var placing_building = false

const building_mid_place_name = "BuildingMidPlace"
const ui_grid_name = "ui_grid"

export var DEBUG = true

func _ready():
	_setup_raw_crystal()

func _setup_raw_crystal():
	var raw_crystal_pos_arr = _get_raw_crystal_pos()

func _get_raw_crystal_pos():
	# Make a temporary grid to get its size
	var temp_grid = _show_ui_grid()
	var grid_size = temp_grid.cell_size
	_hide_ui_grid()
	var art_tiles = $"ArtTiles"
	var map_cell_size = art_tiles.cell_size
	var map_tiles = art_tiles.get_used_cells_by_id(0)
	var first_cell_pos = art_tiles.map_to_world(map_tiles[0])
	var crystal_poss = raw_crystal_manager.get_raw_crystals_pos(
		map_cell_size,
		grid_size,
		map_tiles,
		first_cell_pos
	)
	raw_crystal_manager.set_raw_crystal_poss(crystal_poss)

func _get_sprite(path_to_scene):
	return load(path_to_scene).instance()

func _make_placeable_building(id, my_sprite):
	var building_sprite = _get_sprite("res://src/Buildings/BuildingPlacer.tscn")
	building_sprite.snap_to_grid = funcref(self, "_snap_to_ui_grid")
	building_sprite.name = building_mid_place_name
	building_sprite.set_sprite(
		my_sprite,
		{
			"add_rps": resource_manager._get_func_addrps(),
		}
	)
	add_child(building_sprite)

func _show_ui_grid():
	var ui_background = _get_sprite("res://src/UI/UIGrid.tscn")
	ui_background.layer = 10
	_ui_background = ui_background
	_ui_grid = ui_background.get_child(0).get_child(0)
	add_child(ui_background)
	return _ui_grid

func _hide_ui_grid():
	_ui_background.queue_free()

func _snap_to_ui_grid(coords):
	if not _ui_grid: return coords
	var ret = _ui_grid.snap_to_grid(coords)
	return ret

func _place_building():
	var building_placer = get_node(building_mid_place_name)
	var can_place = building_placer.is_valid_place()
	if can_place:
		placing_building = false
		var placed_sprite = building_placer.place()
		add_child(placed_sprite)
		building_placer.queue_free()
		_hide_ui_grid()

func _input(event):
	if (event is InputEventMouseButton) and event.pressed:
		var evLocal = make_input_local(event)
		if placing_building:
			_place_building()

func _on_Control_building_button_pressed(id, path_to_scene):
	var ui_grid = _show_ui_grid()
	placing_building = true
	var new_building = _get_sprite(path_to_scene)
	# Check to see if the building needs a reference to the crystal manager
	if new_building.name == "RoverGarage":
		new_building.crystal_manager = raw_crystal_manager
	_make_placeable_building(id, new_building)
