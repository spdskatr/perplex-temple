extends Node2D

func change_scene_to_main():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_door_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		change_scene_to_main.call_deferred()


func _on_dude_body_entered(body):
	pass # Replace with function body.
