extends RigidBody2D

func _ready():
	pass

func launch(x, y, force):
	apply_impulse(Vector2.ZERO, Vector2(x * force, y * force))
	
func _on_RigidBody2D_body_entered(body):
	queue_free()
	if body.has_method("hit"):
		body.hit()


