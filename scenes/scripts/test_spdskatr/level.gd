extends Node2D

var player : CharacterBody2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("Player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pad_body_entered(body: Node2D) -> void:
	# You can do some game logic here idk
	print(body)
	pass # Replace with function body.


func _on_door_1_body_entered(body: Node2D) -> void:
	if body == player:
		# Teleport player to other side of door i guess
		player.position = Vector2(180.0, 240.0)
	pass # Replace with function body.


func _on_door_2_body_entered(body: Node2D) -> void:
	if body == player:
		player.position = Vector2(220.0, 20.0)
	pass # Replace with function body.


func _on_door_3_body_entered(body: Node2D) -> void:
	if body == player:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	pass # Replace with function body.
