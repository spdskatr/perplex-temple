extends Node2D

@onready var dialogue = $Dialogue/Panel
var talked1: bool = false
var talked2: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/SliderBox/Panel/HSlider.value = 30
	get_node("Transition").visible = true
	post_spawn.call_deferred()
	
func post_spawn():
	await Global.transition.transit(Color(0, 0, 0, 1), Color(0, 0, 0, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_exit_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		get_node("Transition").visible = true
		await Global.transition.transit(Color(0, 0, 0, 0), Color(0, 0, 0, 1))
		get_tree().change_scene_to_file("res://scenes/levels/level2_shapes.tscn")


func _on_path_is_sealed_dialogue_body_entered(body: Node2D) -> void:
	if talked1 or body is not CharacterBody2D: 
		return
	talked1 = true
	dialogue.queue_text("player", "The path is sealed...")
	dialogue.queue_text("npc", "There's water right there.")
	dialogue.queue_text("player", "But I can't see it from here.")
	dialogue.queue_text("npc", "Just keep it in your head.")
	dialogue.queue_text("npc", "Let go of other visual distractions.")
	dialogue.start_text()


func _on_finish_dialogue_body_entered(body: Node2D) -> void:
	if talked2 or body is not CharacterBody2D:
		return
	talked2 = true
	dialogue.queue_text("player", "I made it out!")
	dialogue.queue_text("player", "\\>|^_^|</")
	dialogue.queue_text("player", "What a deep and insightful gameplay.")
	dialogue.start_text()
	await get_tree().create_timer(60).timeout
	dialogue.queue_text("npc", "By the way, in case you want to speedrun this game, you can press [;] to skip entire passages of text.")
	dialogue.queue_text("player", "Oh yeah, I can also use [Q] and [E] to adjust the brightness/volume slider.")
	dialogue.start_text()

var talked3 = false
func _on_spud_body_entered(body: Node2D) -> void:
	if not talked3 and body is CharacterBody2D:
		talked3 = true
		dialogue.queue_text("player", "...")
		dialogue.queue_text("player", "Are you... me?")
		dialogue.queue_text("placeholder", "\"A friend once described to me how he feels pain in an inability to express himself.\"")
		dialogue.queue_text("placeholder", "\"It took me a while to understand what he meant.\"")
		dialogue.queue_text("placeholder", "\"It took me a while to realise that I was feeling the same thing.\"")
		dialogue.queue_text("player", "...")
		dialogue.queue_text("placeholder", "\"In the depths of my headspace, there's a boy trapped inside a cave.\"")
		dialogue.queue_text("placeholder", "\"A continuous kaleidoscope of colour and noise emanate from the cave walls, bombarding his senses.\"")
		dialogue.queue_text("placeholder", "\"The boy cries for help, but nobody comes to rescue him.\"")
		dialogue.queue_text("player", "...")
		dialogue.queue_text("placeholder", "\"The boy is Spud.\"")
		dialogue.queue_text("player", "...")
		dialogue.queue_text("placeholder", "\"The cave walls are Spud's emotions.\"")
		dialogue.queue_text("placeholder", "\"Words can only do so much to describe them.\"")
		dialogue.queue_text("placeholder", "\"He has to find an outlet to convey the chaos of his feelings.\"")
		dialogue.queue_text("placeholder", "\"...\"")
		dialogue.queue_text("placeholder", "\"What does he do?\"")
		dialogue.queue_text("player", "...")
		dialogue.queue_text("player", "Why is there a drawing of a copy of me sitting in a trash can.")
		dialogue.queue_text("player", "Is this...")
		dialogue.queue_text("player", "fan art?")
		dialogue.start_text()
