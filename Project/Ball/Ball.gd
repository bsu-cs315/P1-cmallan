extends RigidBody2D


var random = RandomNumberGenerator.new()

func _rand():
	var _range = 999
	return (random.randi_range((-_range), (_range)))
	

# Check for Left mouse click
func _on_Ball_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed == true:
			apply_central_impulse( Vector2(_rand(), _rand()))
			print(_rand(), " - ", _rand())

func _process(delta):
	pass

