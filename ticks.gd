extends Label

func _process(delta: float) -> void:
	set_text(str(round(Engine.get_frames_per_second())))
