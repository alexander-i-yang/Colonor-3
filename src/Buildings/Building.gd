extends Sprite

class_name Building

var add_resource_per_second

func shader_red():
	material.set_shader_param("is_red", true)
	material.set_shader_param("is_opaque", true)

func reset_shader():
	material.set_shader_param("is_red", false)
	material.set_shader_param("is_opaque", false)

func is_valid_place():
	var area = get_child(0)
	return area.get_overlapping_areas().empty() and area.get_overlapping_bodies().empty()

func _resolve_incr_resource_per_second(index, val):
	add_resource_per_second.call_func(index, val)

func args(args):
	add_resource_per_second = args["add_rps"]
