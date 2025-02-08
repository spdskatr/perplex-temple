extends HSlider

var menu_open = false
@onready var player = Global.player

func _ready() -> void:
	value_changed.connect(func (value): player.on_slider_changed(self))
	player.on_slider_changed(self)

func _input(event):
	if event.is_action_pressed("ui_cancel"):  # Escape key (default in Godot)
		toggle_menu()

func toggle_menu():
	menu_open = !menu_open
	get_parent().get_parent().visible = menu_open

func get_input():
	var vision_delta = 0
	if Input.is_action_pressed("IncreaseVision"):
		vision_delta += 1
	if Input.is_action_pressed("DecreaseVision"):
		vision_delta -= 1
	return vision_delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_value(value + delta * 100 * (get_input()))
