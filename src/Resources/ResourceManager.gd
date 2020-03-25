extends NinePatchRect

class_name ResourceManager

enum Resources {CRYSTAL, ENERGY, POP, TECH}
var _resources: = []
onready var _timer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize main resource array to contain one empty dict per resource
	for i in Resources:
			var num_resources = 0
			var makers = []
			_resources.append({"num": num_resources, "makers": makers})
			_create_resource_box(i, num_resources, makers)
	
	# Initialize timer
	_timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()

func new_label(text):
	var label = Label.new()
	label.text = str(text)
	return label

func _create_resource_box(id, num, makers):
	var container = HBoxContainer.new()
	container.margin_bottom = 10
	container.margin_top = 10
	container.margin_left = 10
	container.margin_right = 10
	container.add_child(new_label(id))
	container.add_child(new_label(num))
	container.add_child(new_label(makers))

func add_per_second(index, val):
	_resources[index]["makers"].append(val)
	_get_box(index).get_child(2).text = "(+%s)" % str(_compute_add_resources(index))

func _buy_resource(index, val):
	_incr_num(index, -1*val)

func _compute_add_resources(index):
	return sum(_resources[index]["makers"])

func sum(array):
	var ret = 0
	for i in array: ret += i
	return ret

func get_num(index): return _resources[index]["num"]

func _incr_num(index, val): _resources[index]["num"] += val

func _get_box(index): return get_child(0).get_child(index)

func _update_label_num(index):
	_get_box(index).get_child(1).text = str(get_num(index))

func _update_label_rps(index):
	_get_box(index).get_child(2).text = str(_compute_add_resources(index))

func _get_func_addrps(): return funcref(self, "add_per_second")

func _on_Timer_timeout():
	for i in range(0, len(_resources)):
		_incr_num(i, _compute_add_resources(i))
		_update_label_num(i)
