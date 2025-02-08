extends Node2D

var interval : float = 1
var offset : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	offset = Time.get_ticks_msec()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time = Time.get_ticks_msec()
	if (time > offset + interval):
		offset += interval
		if (time > offset + interval):
			offset = time
	else:
		pass
