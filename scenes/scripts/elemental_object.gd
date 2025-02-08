extends Node2D

@export var element: Element.TYPE

func _process(_delta: float) -> void:
	var player = get_node_or_null("../Player")
	var heart = get_node_or_null("../Player/Heart")
	if player:
		$RayCast2D.target_position = $RayCast2D.to_local(player.global_position)
		$RayCast2D.add_exception(player)
		var t = $RayCast2D.get_collider()
		if t == heart:
			player.visible_objects[get_instance_id()] = element
		else:
			player.visible_objects.erase(get_instance_id())
