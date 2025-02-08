extends Node2D

@onready var player : CharacterBody2D = get_node("Player")
@onready var textbox : Panel = get_node("Dialogue/Panel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_pad_body_entered(body: Node2D) -> void:
	# You can do some game logic here idk
	textbox.queue_text("player", "I stepped on the pad!")
	textbox.start_text()
	print(body)


func with_blink(callback):
	var blinking = func():
		player.frozen = true
		await $Transition.transit(Color(0, 0, 0), Color(1, 1, 1))
		callback.call()
		player.frozen = false
	return blinking


func change_scene_to_main():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_door_1_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		# Teleport player to other side of door i guess
		with_blink(func(): player.position = Vector2(180.0, 240.0)).call_deferred()
	pass # Replace with function body.


func _on_door_2_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		with_blink(func(): player.position = Vector2(220.0, 20.0)).call_deferred()
	pass # Replace with function body.


func _on_door_3_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		with_blink(change_scene_to_main).call_deferred()
	pass # Replace with function body.


func _on_pad_2_body_entered(_body: Node2D) -> void:
	textbox.queue_text("player", "HOLY FUCKING SHIT\nIS THAT...")
	textbox.queue_text("player", "IS THAT GOT DAMN CIRNO FROM TOUHOU PROJECT HOLY\n HOLY CRAP")
	textbox.queue_text("npc", "kuba is a nerd")
	textbox.start_text()
	pass # Replace with function body.
