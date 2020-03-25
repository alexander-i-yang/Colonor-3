extends Building

class_name SolarPanel

func place():
	._resolve_incr_resource_per_second(ResourceManager.Resources.ENERGY, 1)
