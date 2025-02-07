extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_h_slider_value_changed(value: float) -> void:
	var slider = get_node("../../SliderBox/HSlider")
	var ratio = (value - slider.min_value) / (slider.max_value - slider.min_value)
	get_node(".").color = Color(36,36,36, ratio)
