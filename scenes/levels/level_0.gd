extends Node2D

@onready var dialogue = $Dialogue/Panel

func change_scene_to_main():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_door_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		change_scene_to_main.call_deferred()


func _on_dude_body_entered(body):
	if body is CharacterBody2D:
		dialogue.queue_text("npc", "Greetings, traveller.")
		dialogue.queue_text("player", "What is this? Where am I?")
		dialogue.queue_text("npc", "You fell down the ravine above us.")
		dialogue.queue_text("npc", "As you might have already guessed, you're not coming out the same way.")
		dialogue.queue_text("player", "Is there another way out?")
		dialogue.queue_text("npc", "Yes, but it won't be easy.")
		dialogue.queue_text("npc", "The only path out leads even deeper into the cave, right through the Perplex Temple.")
		dialogue.queue_text("npc", "A temple? Undergound?")
		
		dialogue.start_text()
