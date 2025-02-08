extends Node2D

@onready var textbox : Panel = get_node("Dialogue/Panel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var has_entered: bool = false
func _on_pad_body_entered(body: Node2D) -> void:
	if has_entered:
		return
	has_entered = true
	textbox.queue_text("npc", "Close your eyes...")
	textbox.queue_text("npc", "and listen.")
	textbox.start_text()
