extends StaticBody2D


# when you touch the spikes you die. no shit.
func _on_area_2d_body_entered(body):
	body.queue_free()
	Globals.dead = true
	Globals.death_cause = "spike"
