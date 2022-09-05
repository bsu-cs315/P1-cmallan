extends Node2D


var _game_started = false


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_ball()
	_game_started == true
	
func spawn_ball():
	var ball : RigidBody2D = load("res://Project/Ball/Ball.tscn").instance()
	ball.position = Vector2(54, 463)
	call_deferred("add_child", ball)
	
func restart():
	var _restart_game = get_tree().change_scene("res://Project/World/World.tscn")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _game_started == true:
		if Input.is_action_just_pressed("restart"):
			restart()