extends Node2D


var _game_started = false


# Called when the node enters the scene tree for the first time.
func _ready():
	_game_started == true
	
	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _game_started == true:
		_on_Button_pressed()
	
	
func _on_flag_hit(ball, flag):
	if ball == $Ball:
		print("hit")
		call_deferred("remove_child", ball)
		call_deferred("remove_child", flag)
		var _restart_game = get_tree().change_scene("res://Project/World/World.tscn")
	



func _on_Button_pressed():
	var _restart_game = get_tree().change_scene("res://Project/World/World.tscn")
