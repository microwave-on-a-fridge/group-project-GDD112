extends Area2D


# when you touch the spikes you die. no shit.
func _on_body_entered(body):
	body.queue_free()
	Globals.dead = true
