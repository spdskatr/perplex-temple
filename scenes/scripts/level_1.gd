extends Node2D

@onready var dialogue = $Dialogue/Panel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD.enable_menu_toggle = false
	$HUD/SliderBox/Panel/HSlider.value = 25
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_tutorial_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		dialogue.queue_text("npc", "Remember, you can always press [R] or [F5] to reset!")
		dialogue.queue_text("player", "Yeah, yeah...")
		dialogue.start_text()
