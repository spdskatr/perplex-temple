extends Node2D

@export var element: Element.TYPE
@onready var player = Global.player
@export var visibility: VisibleOnScreenNotifier2D
var apply_timeout: float = 0

func _ready() -> void:
	$RayCast2D.add_exception(player)

func _process(_delta: float) -> void:
	var heart = player.get_node("Heart")
	if visibility.is_on_screen():
		$RayCast2D.target_position = $RayCast2D.to_local(player.global_position)
		var t = $RayCast2D.get_collider()
		if t == heart:
			apply_timeout = 0
			player.visible_objects[get_instance_id()] = element
		else:
			_deapply_tick(_delta)
	else:
		_deapply_tick(_delta)

func _deapply_tick(_delta):
	apply_timeout += _delta
	if apply_timeout > 0.1:
		player.visible_objects.erase(get_instance_id())
