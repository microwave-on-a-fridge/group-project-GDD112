extends Area2D

# this is such an easy thing to do im kinda dumb for not figuring it out for so long


func _on_body_entered(body):
	body.queue_free()
	Globals.dead = true
