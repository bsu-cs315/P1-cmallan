extends Node2D


var _game_started = false


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_ball()
	spawn_flag()
	_game_started == true
	
	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _game_started == true:
		_on_Button_pressed()
	
func spawn_ball():
	var ball : RigidBody2D = load("res://Project/Ball/Ball.tscn").instance()
	ball.position = Vector2(65, 237)
	call_deferred("add_child", ball)

func spawn_flag():
	var flag : Area2D = load("res://Project/Flag/Flag.tscn").instance()
	var _flag_connect = flag.connect("body_enter", self, "_on_flag_hit", [flag])
	flag.position = Vector2(170, 78)
	call_deferred("add_child", flag)
	
func _on_flag_hit(ball, flag):
	if ball == $Ball:
		print("hit")
		call_deferred("remove_child", ball)
		call_deferred("remove_child", flag)
		spawn_ball()
		spawn_flag()
	



func _on_Button_pressed():
	var _restart_game = get_tree().change_scene("res://Project/World/World.tscn")
