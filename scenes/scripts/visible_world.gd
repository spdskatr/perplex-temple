extends Node2D

@onready var player = Global.player

func _ready() -> void:
	pass

const TRANSITION_PERIOD: float = 1000
var time_transition_initial: float = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var ratio = player.ratio
	if time_transition_initial < 0:
		material.set_shader_parameter("brightness", interpolate(interpolate(ratio)))
	else:
		var weight = 1 - min(1, (Time.get_ticks_msec() - time_transition_initial) / TRANSITION_PERIOD)
		material.set_shader_parameter("brightness", interpolate(interpolate(1 - weight * (1 - ratio))))
		
func interpolate(x: float) -> float:
	return x * (17. + x * -18. + x * x * 7.) / 6. 
