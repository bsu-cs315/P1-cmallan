extends Sprite


const ballPath = preload("res://Project/Ball/Ball.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees = max(min(rotation_degrees, 0), -90)
	
	if self.scale.x > 3:
		self.scale.x = 3
	elif self.scale.x < 0.5:
		self.scale.x = 0.5
	
	if Input.is_action_pressed("ui_up"):
		self.rotate(-0.05)
	elif Input.is_action_pressed("ui_down"):
		self.rotate(0.05)
	elif Input.is_action_pressed("ui_left"):
		self.scale.x -= .01
	elif Input.is_action_pressed("ui_right"):
		self.scale.x += .01
	elif Input.is_action_just_pressed("launch"):
		var ball = ballPath.instance()
		get_parent().add_child(ball)
		ball.position = self.position
		ball.launch(90+(rotation_degrees), 0+(rotation_degrees), self.scale.x * 3)
