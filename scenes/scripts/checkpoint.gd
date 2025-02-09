extends Node2D

signal checkpoint_saved

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == Global.player:
		Global.player.checkpoint_pos = position
	checkpoint_saved.emit()
