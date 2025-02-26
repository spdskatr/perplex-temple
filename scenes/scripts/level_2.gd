extends Node2D

@onready var dialogue = $Dialogue/Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/SliderBox/Panel/HSlider.value = 30
	post_spawn.call_deferred()
	Global.transition.visible = true
	Global.transition.update(Color.BLACK)
	
func post_spawn():
	await Global.transition.transit(Color(0, 0, 0, 1), Color(0, 0, 0, 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var was_dead_end_reached = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if !was_dead_end_reached and body is CharacterBody2D:
		was_dead_end_reached = true
		dialogue.queue_text("player", "Dead end...")
		dialogue.queue_text("npc", "I think I saw the corridor on the right a bit earlier.")
		dialogue.queue_text("player", "But if I move back, I'll slide right back!")
		dialogue.queue_text("player", "So, how do I not slide?")
		dialogue.queue_text("npc", "hmm...")
		dialogue.queue_text("npc", "Try closing your eyes?")
		dialogue.queue_text("player", "                                         umm")
		dialogue.queue_text("npc", "...?")
		dialogue.queue_text("player", "Uhh...")
		dialogue.queue_text("player", "(how do i close my eyes)")
		dialogue.queue_text("npc", "Can you not close your eyes?")
		dialogue.queue_text("player", "...")
		dialogue.queue_text("player", "help how do i close my eyes.")
		dialogue.queue_text("npc", "...what")
		dialogue.queue_text("npc", "...try the options menu")
		
		dialogue.start_text()

func _on_exit_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		get_node("Transition").visible = true
		await Global.transition.transit(Color(0, 0, 0, 0), Color(0, 0, 0, 1))
		get_tree().change_scene_to_file("res://scenes/levels/level2_shapes.tscn")
