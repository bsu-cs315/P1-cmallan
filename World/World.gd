extends Node2D


var _game_started = false
var _flag_hit = false
var _balls_available = 3
var _score = 0
var _sleep_counter = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD/BallsLeft.visible = false
	$HUD/Angle.visible = false
	$HUD/Power.visible = false
	$HUD/Score.visible = false
	spawn_Ball()
	spawn_flag()
	_game_started = true
	# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta):
	if _game_started == true:
		if _balls_available > 0:
			$HUD/BallsLeft.visible = true
			$HUD/Angle.visible = true
			$HUD/Power.visible = true
			$HUD/Score.visible = true
			$TitleReturn.visible = false
			var _power = $Ball.get_power()
			var _angle = $Ball.get_angle()
			on_Power_update(_power)
			on_Angle_update(_angle)
			
		elif _balls_available == 0:
			$HUD/Score.visible = true
			$HUD/BallsLeft.visible = false
			$HUD/Angle.visible = false
			$HUD/Power.visible = false
			$TitleReturn.visible = true
		$HUD/BallsLeft.text = "Balls Left: " + str(_balls_available)
		$HUD/Score.text = "Score: " + str(_score)
		
			
func _on_flag_hit(ball, flag):
	$FlagHit.play()
	if ball == $Ball:
		_flag_hit = true
		call_deferred("remove_child", ball)
		call_deferred("remove_child", flag)
		_balls_available -= 1
		_score += 1
		_sleep_counter = 0
		if _balls_available > 0:
			spawn_Ball()
			spawn_flag()
	
func on_Projectile_sleep():
	_sleep_counter += 1
	if _sleep_counter == 3:
		if _flag_hit == false:
			if _balls_available > 0:
				_balls_available -= 1
				respawn()

func spawn_Ball():
	var ball : RigidBody2D = load("res://Ball/Ball.tscn").instance()
	var _ball_connect = ball.connect("sleeping_state_changed", self, "on_Projectile_sleep")
	ball.position = Vector2(71, 237)
	call_deferred("add_child", ball)
	
func spawn_flag():
	var flag : Area2D = load("res://Flag/Flag.tscn").instance()
	var _flag_connect = flag.connect("body_entered", self, "_on_flag_hit", [flag])
	flag.position = Vector2(465, 140)
	call_deferred("add_child", flag)
	_flag_hit = false
	
func respawn():
	var _ball = $Ball.get_ball()
	call_deferred("remove_child", _ball)
	spawn_Ball()
	_sleep_counter = 0

func _on_Button_pressed():
	var _restart_game = get_tree().change_scene("res:///World/World.tscn")
	
func on_Power_update(new_power):
	$HUD/Power.text  = "Power: %d" % int(new_power / 12) + "%"
	
func on_Angle_update(new_angle):
	$HUD/Angle.text = "Angle: " + str(int(-new_angle)) + "°"


func _on_TitleReturn_pressed():
	var _ignored := get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")
