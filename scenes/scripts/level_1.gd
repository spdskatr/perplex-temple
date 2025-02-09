extends Node2D

@onready var dialogue = $Dialogue/Panel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD.enable_menu_toggle = false
	$HUD/SliderBox/Panel/HSlider.value = 25
	post_spawn_dialogue.call_deferred()
	pass # Replace with function body.

func post_spawn_dialogue():
	await get_tree().create_timer(1).timeout
	dialogue.queue_text("player", "It's dark in here...")
	await dialogue.start_text()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var btn_tutorial_done = false
func _on_big_checkpoint_body_entered(body: Node2D) -> void:
	$Player.checkpoint_pos = $BigCheckpoint.position
	if not btn_tutorial_done and body is CharacterBody2D:
		btn_tutorial_done = true
		dialogue.queue_text("npc", "Remember, you can always press [R] or [F5] to reset!")
		dialogue.queue_text("player", "Yeah, yeah...")
		dialogue.start_text()
