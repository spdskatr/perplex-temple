extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pad_body_entered(body: Node2D) -> void:
	# You can do some game logic here idk
	print(body)
	pass # Replace with function body.
