extends CanvasLayer

@export var enable_menu_toggle : bool = true
var menu_open = false

func _ready() -> void:
	Global.hud = self

func _input(event):
	if event.is_action_pressed("settings") and enable_menu_toggle:
		toggle_menu()

func toggle_menu():
	menu_open = !menu_open
	$SliderBox.visible = menu_open
	$SliderBox/Panel/HSlider.enabled = menu_open

var is_prompting_restart: int = 0
var time_of_restart_prompt: float = 0.
func prompt_restart() -> void:
	is_prompting_restart = 1
	time_of_restart_prompt = Time.get_ticks_msec()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_prompting_restart != 0 && (Global.player.velocity != Vector2.ZERO || !Element_set.slides(Global.player.get_elements())):
		is_prompting_restart = 0
		$RestartPrompt.self_modulate.a = 0
	if !enable_menu_toggle && is_prompting_restart == 0 && Global.player.velocity == Vector2.ZERO && Element_set.slides(Global.player.get_elements()):
		prompt_restart.call_deferred()
	elif is_prompting_restart == 1:
		$RestartPrompt.self_modulate.a = min(1, (Time.get_ticks_msec() - time_of_restart_prompt) / 1000.)
		
	
		
