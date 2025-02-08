extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var slider = get_node("/root/TestSlider/HUD/SliderBox/HSlider")
	slider.value_changed.connect(_on_slider_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_slider_changed(value: float) -> void:
	var slider = get_node("/root/TestSlider/HUD/SliderBox/HSlider")
	var ratio = (slider.value - slider.min_value) / (slider.max_value - slider.min_value)
	material.set_shader_parameter("brightness", ratio)
