extends Node2D

@onready var player = Global.player

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var ratio = player.ratio
	material.set_shader_parameter("brightness", ratio)

func _on_slider_changed(value: float) -> void:
	pass
