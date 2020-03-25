extends TileMap

class_name UIGrid

var tilemap

func snap_to_grid(pos):
	var ret = pos.snapped(cell_size)
	return ret
