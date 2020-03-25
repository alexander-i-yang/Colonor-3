extends CanvasLayer

signal building_button_pressed(index)

# TODO: move this to a csv or something
export(Array, Dictionary) var building_buttons = [
	{"id": "Rover Garage", "path_to_scene": "res://src/Buildings/Rover Garage.tscn"},
	{"id": "Solar Panel", "path_to_scene": "res://src/Buildings/SolarPanel.tscn"}
]

func _create_centered_label(text):
	var label = Label.new()
	label.text = text
	label.align = label.ALIGN_CENTER
	label.valign = label.ALIGN_CENTER
	label.size_flags_horizontal = label.SIZE_EXPAND
	label.size_flags_vertical = label.SIZE_FILL
	return label

func _create_button(id, normal_path, pressed_path):
	var button = TextureButton.new()
	button.texture_normal = load(normal_path)
	button.texture_pressed = load(pressed_path)
	button.name = id
	return button

func _ready():
	for button_dict in building_buttons:
		var id = button_dict["id"]
		var path_to_scene = button_dict["path_to_scene"]
		var button = _create_button(
			id,
			"res://assets/kennyui/PNG/blue_button09.png",
			"res://assets/kennyui/PNG/blue_button10.png"
		)
		button.add_child(_create_centered_label(id))
		$"Control/NinePatchRect/BuildingButtons".add_child(button)
		button.connect(
			"pressed",
			self,
			"_building_button_pressed",
			[id, path_to_scene]
		)

func _building_button_pressed(id, path):
	emit_signal("building_button_pressed", id, path)
