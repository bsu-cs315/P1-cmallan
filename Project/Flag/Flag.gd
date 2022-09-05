extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#if hit, prints that it was hit and removes itself
func hit():
	print("Target hit.")
	queue_free()



