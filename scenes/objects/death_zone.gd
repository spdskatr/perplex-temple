extends Area2D

const time_to_die: float = 0.15
var timeout: float = 0.0

func _process(_delta):
	for body in get_overlapping_bodies():
		if body is Player:
			if !body.is_wet():
				timeout += _delta
				if timeout > time_to_die:
					body.die()
			else:
				timeout = 0
