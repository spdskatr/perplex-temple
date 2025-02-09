extends Node2D

@onready var dialogue = $Dialogue/Panel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD.enable_menu_toggle = false
	$HUD/SliderBox/Panel/HSlider.value = 30
	post_spawn_dialogue.call_deferred()
	pass # Replace with function body.

var disable_shift_tutorial = false
func _on_shift_tutorial_disable_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		disable_shift_tutorial = true

func post_spawn_dialogue():
	await get_tree().create_timer(1).timeout
	dialogue.queue_text("player", "It's dark in here...")
	await dialogue.start_text()
	await get_tree().create_timer(5).timeout
	if not disable_shift_tutorial:
		dialogue.queue_text("player", "Why is moving so difficult, all of a sudden?")
		dialogue.queue_text("npc", "Are you looking at a boulder?")
		dialogue.queue_text("player", "Um... yeah, I see a boulder here...")
		dialogue.queue_text("npc", "Remember what I said about senses spilling over?")
		dialogue.queue_text("npc", "Seeing a boulder causes you to feel heavy.")
		dialogue.queue_text("npc", "When you're heavy, you cannot move. The only way to move again is to look away from the boulder.")
		dialogue.queue_text("player", "Oh...")
		dialogue.queue_text("npc", "Hold [SHIFT] to move without changing your viewing direction.")
		dialogue.start_text()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var btn_tutorial_done = false
func _on_big_checkpoint_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Player.checkpoint_pos = $BigCheckpoint.position
		if not btn_tutorial_done:
			btn_tutorial_done = true
			dialogue.queue_text("npc", "Remember, you can always press [R] or [F5] to reset!")
			dialogue.queue_text("player", "Yeah, yeah...")
			dialogue.start_text()


func _on_level_end_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		next_scene.call_deferred()

func next_scene():
	get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")


var ice_tutorial_done = false
func _on_ice_tut_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not ice_tutorial_done:
		ice_tutorial_done = true
		dialogue.queue_text("player", "That's an ice block...")
		dialogue.queue_text("npc", "Ice blocks turn you into ice, which stops you from moving or changing direction.")
		dialogue.queue_text("npc", "Ice is also slippery, so if you were moving before you turned into ice, you maintain your speed and slide along the ground.")
		dialogue.queue_text("player", "What if I'm also heavy?")
		dialogue.queue_text("npc", "If you become heavy while iced, you continue moving until you're no longer iced.")
		dialogue.queue_text("player", "Huh.")
		dialogue.queue_text("npc", "Oh, before I forget...")
		dialogue.queue_text("npc", "If you find yourself stuck, you can press [R] or [F5] to restart the current puzzle.")
		dialogue.start_text()
		

var water_tutorial_done = false
func _on_water_tut_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not water_tutorial_done:
		water_tutorial_done = true
		dialogue.queue_text("player", "Water fountain...")
		dialogue.queue_text("npc", "If you touch fire, the puzzle resets.")
		dialogue.queue_text("npc", "Water fountains make you immune to fire.")
		dialogue.queue_text("player", "Neat.")
		dialogue.start_text()

var pep_talk_done = false
func _on_hard_puzzle_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not pep_talk_done:
		pep_talk_done = true
		dialogue.queue_text("npc", "I've been told that this next puzzle is a bit difficult.")
		dialogue.queue_text("npc", "Good luck!")
		dialogue.queue_text("player", "...")
		dialogue.start_text()
