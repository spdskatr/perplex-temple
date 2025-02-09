extends HSlider

var menu_open = false
@export var enabled = false
@onready var player = Global.player

func _ready() -> void:
	value_changed.connect(func (value): player.on_slider_changed(self))
	player.on_slider_changed(self)

func get_input():
	var vision_delta = 0
	if Input.is_action_pressed("IncreaseVision"):
		vision_delta += 1
	if Input.is_action_pressed("DecreaseVision"):
		vision_delta -= 1
	return vision_delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enabled:
		set_value(value + delta * 100 * (get_input()))
