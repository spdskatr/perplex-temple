extends Node2D

@onready var dialogue = $Dialogue/Panel

func change_scene_to_main():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_door_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		await Global.transition.transit(Color(0, 0, 0), Color(0, 0, 0))
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
		dialogue.queue_text("player", "How strange, why would anyone build a temple down below?")
		dialogue.queue_text("npc", "The creators were seeking complete solitude - a place devoid of all worldly distractions.")
		dialogue.queue_text("npc", "They needed a place to practice the sacred art of...")
		dialogue.queue_text("npc", "Synaesthesia")
		dialogue.queue_text("player", "What is that?")
		dialogue.queue_text("npc", "When one sense is activated, some of its energy spills over to the rest.")
		dialogue.queue_text("npc", "Just like seeing a campfire far far away might might make you feel a sliver of warmth despite the distance.")
		dialogue.queue_text("npc", "Or coming across a massive boulder might make you just a bit more wary of the weight of your own steps.")
		dialogue.queue_text("player", "I don't understand, how is this meaningful?")
		dialogue.queue_text("npc", "Sometimes, your sense of reality is more important than the reality itself.")
		dialogue.queue_text("npc", "And there's no better testament to this, than the wonder that is Perplex Temple.")
		dialogue.queue_text("player", "Are you telling me I can make something real if I believe in it?")
		dialogue.queue_text("npc", "Indeed, but it requires utmost focus and something observable to stimulate your senses.")
		dialogue.queue_text("npc", "You will soon see for yourself.")
		dialogue.queue_text("player", "Alright, let's ball.")
		dialogue.queue_text("npc", "Cool.")
		dialogue.queue_text("npc", "Take this walkie-talkie, mate. Ring me up if you get stuck on your way out.")
		
		dialogue.start_text()
