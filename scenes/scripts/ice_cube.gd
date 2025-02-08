extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = get_node_or_null("../Player")
	var heart = get_node_or_null("../Player/Heart")
	if player:
		$RayCast2D.target_position = $RayCast2D.to_local(player.global_position)
		var t = $RayCast2D.get_collider()
		if t == heart:
			print("hit!")
		else:
			print("no")
