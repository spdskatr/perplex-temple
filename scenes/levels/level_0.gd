extends Node2D

@onready var dialogue = $Dialogue/Panel
var talked: bool = false

func _ready() -> void:
	$HUD/SliderBox/Panel/HSlider.value = 30
	$HUD.enable_menu_toggle = false

func change_scene_to_main():
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

func with_blink(callback):
	var blinking = func():
		Global.player.frozen = true
		await Global.transition.transit(Color(0, 0, 0, 0), Color(0, 0, 0, 1))
		callback.call()
		Global.player.frozen = false
	return blinking

func _on_door_body_entered(body: Node2D) -> void:
	if talked and body is CharacterBody2D:
		with_blink(change_scene_to_main).call_deferred()


func _on_dude_body_entered(body):
	talked = true
	if body is CharacterBody2D:
		dialogue.queue_text("npc", "Greetings, traveller.")
		dialogue.queue_text("player", "...what is this place?")
		dialogue.queue_text("npc", "You fell down the ravine above us.")
		dialogue.queue_text("npc", "As you might have already guessed, you're not coming out the same way.")
		dialogue.queue_text("player", "Is there another way out?")
		dialogue.queue_text("npc", "Yes, but it won't be easy.")
		dialogue.queue_text("npc", "The only path out leads even deeper into the cave, right through the Perplex Temple.")
		dialogue.queue_text("player", "Perplex Temple?")
		dialogue.queue_text("player", "Why would anyone build a temple in a cave?")
		dialogue.queue_text("npc", "The creators were seeking complete solitude - a place devoid of all worldly distractions.")
		dialogue.queue_text("npc", "They needed a place to practice the sacred art of...")
		dialogue.queue_text("npc", "S y n a e s t h e s i a")
		dialogue.queue_text("player", "Synaesthesia?")
		dialogue.queue_text("player", "Like that thing where you associate numbers with colours?")
		dialogue.queue_text("npc", "Indeed.")
		dialogue.queue_text("npc", "In the Perplex Temple, when one sense is activated, some of its energy spills over to the rest.")
		dialogue.queue_text("npc", "Just like seeing a campfire far far away might make you feel a sliver of warmth despite the distance.")
		dialogue.queue_text("npc", "Or coming across a massive boulder might make you just a bit more wary of the weight of your own steps.")
		dialogue.queue_text("player", "...")
		dialogue.queue_text("player", "(visible confusion)")
		dialogue.queue_text("npc", "Sometimes, your perception of reality is more important than the reality itself.")
		dialogue.queue_text("npc", "And there's no better testament to this, than the wonder that is the Perplex Temple.")
		dialogue.queue_text("player", "So... I... can make something real by believing that it's real?")
		dialogue.queue_text("npc", "Indeed, but it requires utmost focus, as well as something observable to stimulate your senses.")
		dialogue.queue_text("npc", "You will soon see for yourself.")
		dialogue.queue_text("player", "...")
		dialogue.queue_text("player", "why the ominous words man i just wanna get out of here")
		dialogue.queue_text("npc", "...")
		dialogue.queue_text("npc", "Here, take this walkie-talkie. I'll guide you through the temple.")
		dialogue.queue_text("player", "Thanks...")
		
		dialogue.start_text()
		await dialogue.done()
		$LockedDoor.visible = false
