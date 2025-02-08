extends CanvasLayer

@export var enable_menu_toggle : bool = true
var menu_open = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):  # Escape key (default in Godot)
		toggle_menu()

func toggle_menu():
	menu_open = !menu_open
	$SliderBox.visible = menu_open
	$SliderBox/Panel/HSlider.enabled = menu_open
