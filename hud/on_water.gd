extends Node2D

@onready var player = Global.player

func _process(delta: float) -> void:
	visible = Element_set.wet(player.get_elements())
