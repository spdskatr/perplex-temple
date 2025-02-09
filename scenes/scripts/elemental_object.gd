extends Node2D

@export var element: Element.TYPE
@onready var player = Global.player
@export var visibility: VisibleOnScreenNotifier2D

func _process(_delta: float) -> void:
	var heart = player.get_node("Heart")
	$RayCast2D.target_position = $RayCast2D.to_local(player.global_position)
	$RayCast2D.add_exception(player)
	var t = $RayCast2D.get_collider()
	if t == heart and visibility.is_on_screen():
		player.visible_objects[get_instance_id()] = element
	else:
		player.visible_objects.erase(get_instance_id())
