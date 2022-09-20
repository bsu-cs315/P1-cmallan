extends RigidBody2D

signal angle_change(new_angle)
signal power_change(new_power)

var _ball_angle = 0
var _power = 150
var _velocity = 0
var _rotation = 30
var _is_launched = false




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("launch"):
		if _is_launched == false:
			var _angle = Vector2.RIGHT.rotated(deg2rad(_ball_angle))
			var impulse = _angle * _velocity
			apply_impulse(Vector2.ZERO, impulse)
			$ArrowNode.visible = false
			$LaunchSound.play()
			_is_launched = true

	if Input.is_action_pressed("increase_angle"):
		if _is_launched == false:
			_ball_angle -= _rotation * delta
			_ball_angle = clamp(_ball_angle, -90, 0)
			emit_signal("angle_change", _ball_angle)
			update_angle(_ball_angle)
			
	if Input.is_action_pressed("decrease_angle"):
		if _is_launched == false:
			_ball_angle += _rotation * delta
			_ball_angle = clamp(_ball_angle, -90, 0)
			emit_signal("angle_change", _ball_angle)
			update_angle(_ball_angle)
			
	if Input.is_action_pressed("decrease_power"):
		if _is_launched == false:
			_velocity -= _power * delta
			_velocity = clamp(_velocity, 1, 900)
			emit_signal("power_change", _power)
			$ArrowNode/Arrow.scale.x -= .01
			
			
	if Input.is_action_pressed("increase_power"):
		if _is_launched == false:
			_velocity += _power * delta
			_velocity = clamp(_velocity, 1, 900)
			emit_signal("power_change", _power)
			$ArrowNode/Arrow.scale.x += .01
			
		
	
		
func update_angle(ball_angle):
	$ArrowNode/Arrow.rotation_degrees = ball_angle

func get_angle():
	return _ball_angle

func get_power():
	return _velocity
	
func get_ball():
	return self

