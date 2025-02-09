extends Node2D

@export var element: Element.TYPE
@onready var player = Global.player
@export var visibility: VisibleOnScreenNotifier2D
var apply_timeout: float = 0
var til_frame: float = 0.2

func _ready() -> void:
	$RayCast2D.add_exception(player)

func _process(_delta: float) -> void:
	til_frame -= _delta
	if til_frame < 0:
		til_frame = 0.2
		var sprite = get_node_or_null("Sprite2D")
		if sprite:
			sprite.frame = (sprite.frame + 1) % (sprite.vframes * sprite.hframes)
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
