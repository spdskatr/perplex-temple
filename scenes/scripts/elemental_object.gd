extends Node2D

@export var element: Element.TYPE
@onready var player = Global.player
@export var visibility: VisibleOnScreenNotifier2D
var timeout: float = 0

func _ready() -> void:
	$RayCast2D.add_exception(player)

func _process(_delta: float) -> void:
	var heart = player.get_node("Heart")
	$RayCast2D.target_position = $RayCast2D.to_local(player.global_position)
	var t = $RayCast2D.get_collider()
	if t == heart and visibility.is_on_screen():
		timeout = 0
		player.visible_objects[get_instance_id()] = element
	else:
		timeout += _delta
		if timeout > 0.1:
			player.visible_objects.erase(get_instance_id())
