extends Node2D

@onready var dialogue = $Dialogue/Panel
var talked1: bool = false
var talked2: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/SliderBox/Panel/HSlider.value = 30
	pass # Replace with function body.


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
