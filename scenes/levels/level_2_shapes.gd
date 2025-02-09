extends Node2D

var has_wall_crumbled: bool = false

@onready var hud = Global.hud
@onready var player = Global.player
@onready var dialogue = $Dialogue/Panel

var rng = RandomNumberGenerator.new()

enum ColorA {
	RED,
	GREEN,
	BLUE,
}

enum ColorS {
	CYAN,
	MAGENTA,
	YELLOW,
}

const COLOR_A_COLORS: Array[Color] = [Color.RED, Color.GREEN, Color.BLUE]
const COLOR_S_COLORS: Array[Color] = [Color.CYAN, Color.MAGENTA, Color.YELLOW]

var target_color_a: ColorA = ColorA.RED
var target_color_s: ColorS = ColorS.CYAN
var is_closed_a: Array[bool] = [false, false, false]
var is_closed_s: Array[bool] = [false, false, false]
var has_solved_a: bool = false
var has_solved_s: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/SliderBox/Panel/HSlider.value = 30
	$VisibleWorld/Player.rotation = -PI / 2
	Global.transition.visible = true
	Global.transition.update(Color.BLACK)
	rng.randomize()
	var slider = hud.get_node("SliderBox/Panel/HSlider")
	slider.value_changed.connect(_on_slider_changed)
	post_spawn.call_deferred()
	
func post_spawn():
	await Global.transition.transit(Color(0, 0, 0, 1), Color(0, 0, 0, 0))
	dialogue.queue_text("player", "I can't see a way out...")
	await dialogue.start_text()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_slider_changed(value: float) -> void:
	if !has_wall_crumbled:
		var slider = hud.get_node("SliderBox/Panel/HSlider")
		var ratio = (slider.value - slider.min_value) / (slider.max_value - slider.min_value)
		if ratio == 0:
			crumble_wall()
			
func crumble_wall() -> void:
	has_wall_crumbled = true
	# 29 2 - 30 3
	var walls: TileMapLayer = get_tree().current_scene.get_node("VisibleWorld/Walls")
	for i in range(2):
		for j in range(4):
			walls.set_cell(Vector2i(29 + i, 2 + j))
	var particle_spawner = get_tree().current_scene.get_node("AudibleWorld/ParticleSpawnerCrumbleWall")
	for _i in range(2):
		for dur in [0.1, 0.05, 0.05]:
			await get_tree().create_timer(dur).timeout
			particle_spawner.spawn_particle()
			
	$AudioCrumble.play()
	get_tree().current_scene.get_node("VisibleWorld").time_transition_initial = Time.get_ticks_msec()
	await get_tree().create_timer(1).timeout
	reset_puzzle()

func play_color_a_sound(color: ColorA):
	var audio = $AudioTone
	audio.pitch_scale = 1 + 0.5 * color
	audio.play()

func play_color_s_sound(color: ColorS):
	var audio = $AudioTone
	audio.pitch_scale = 2.5 + 0.5 * color
	audio.play()
	
func close_door_a(color_a: ColorA, should_close: bool) -> void:
	is_closed_a[color_a] = should_close
	var walls: TileMapLayer = get_tree().current_scene.get_node("VisibleWorld/Walls")
	for i in range(2):
		for j in range(2):
			walls.set_cell(Vector2i(19 + i + color_a * 4, -6 + j - color_a), 1, Vector2(i + (2 if should_close else 0), j))
	if should_close:
		play_color_a_sound(color_a)

func close_door_s(color_s: ColorS, should_close: bool) -> void:
	is_closed_s[color_s] = should_close
	var walls: TileMapLayer = get_tree().current_scene.get_node("VisibleWorld/Walls")
	for i in range(2):
		for j in range(2):
			walls.set_cell(Vector2i(31 + i + color_s * 4, -6 + j - 2 + color_s), 1, Vector2(i + (2 if should_close else 0), j))
	if should_close:
		play_color_s_sound(color_s)

func _on_pad_reset_body_entered(body: Node2D) -> void:
	if body.get_instance_id() == player.get_instance_id():
		if is_level_done:
			return
		reset_puzzle()
	
func reset_puzzle() -> void:
	has_solved_a = false
	has_solved_s = false
	
	target_color_a = rng.randi_range(0, ColorA.size() - 1)
	target_color_s = rng.randi_range(0, ColorS.size() - 1)
	
	for i in range(is_closed_a.size()):
		close_door_a(i, false)
	for i in range(is_closed_s.size()):
		close_door_s(i, false)
	
	provide_goals()

func provide_goals() -> void:
	var particle_spawner = get_tree().current_scene.get_node("AudibleWorld/ParticleSpawnerHint")
	if !has_solved_a:
		particle_spawner.color = COLOR_A_COLORS[target_color_a]
		particle_spawner.arity = rng.randi_range(3, 6)
		particle_spawner.spawn_particle()
		play_color_a_sound(target_color_a)
		await get_tree().create_timer(0.5).timeout
	
	if !has_solved_s:
		particle_spawner.color = COLOR_S_COLORS[target_color_s]
		particle_spawner.arity = rng.randi_range(3, 6)
		particle_spawner.spawn_particle()
		play_color_s_sound(target_color_s)

func should_ignore_door_enter() -> bool:
	var number_closed: int = 0
	for b in is_closed_a:
		number_closed += int(b)
	for b in is_closed_s:
		number_closed += int(b)
	if number_closed >= 2:
		return true
	return false

func _on_door_entered_a(body: Node2D, color: ColorA) -> void:
	if body.get_instance_id() == player.get_instance_id() && !is_closed_a[color]:
		if should_ignore_door_enter():
			return
		close_door_a(color, true)
		on_door_entered_cleanup()
		
func _on_door_entered_s(body: Node2D, color: ColorS) -> void:
	if body.get_instance_id() == player.get_instance_id() && !is_closed_s[color]:
		if should_ignore_door_enter():
			return
		close_door_s(color, true)
		on_door_entered_cleanup()
			
var has_color_combined_hint_actived = false
func provide_color_hint() -> void:
	has_color_combined_hint_actived = true
	dialogue.queue_text("player", "How can I combine the colours before me to make the ones I hear?")
	await dialogue.start_text()

var is_level_done = false

func on_door_entered_cleanup() -> void:
	var number_closed_a: int = 0
	for b in is_closed_a:
		if b:
			number_closed_a += 1
	var number_closed_s: int = 0
	for b in is_closed_s:
		if b:
			number_closed_s += 1
	if number_closed_a + number_closed_s < 2:
		return
	
	var particle_spawner = get_tree().current_scene.get_node("AudibleWorld/ParticleSpawnerHint")
	
	var should_provide_color_hint = false
	
	if !has_solved_a && is_closed_s[(target_color_a + 1) % is_closed_s.size()] && is_closed_s[(target_color_a + 2) % is_closed_s.size()]:
		has_solved_a = true
	elif !has_solved_s && is_closed_a[(target_color_s + 1) % is_closed_a.size()] && is_closed_a[(target_color_s + 2) % is_closed_a.size()]:
		has_solved_s = true
	elif !has_color_combined_hint_actived && !has_solved_a && !has_solved_s && is_closed_a[target_color_a] && is_closed_s[target_color_s]:
		should_provide_color_hint = true
		
	if number_closed_s == 2:
		for i in is_closed_s.size():
			if !is_closed_s[i]:
				await get_tree().create_timer(0.5).timeout
				play_color_a_sound(i)
				for dur in [0.1, 0.05, 0.05]:
					particle_spawner.color = COLOR_A_COLORS[i]
					particle_spawner.arity = rng.randi_range(3, 6)
					await get_tree().create_timer(dur).timeout
					particle_spawner.spawn_particle()
				break
	elif number_closed_a == 2:
		for i in is_closed_a.size():
			if !is_closed_a[i]:
				await get_tree().create_timer(0.5).timeout
				play_color_s_sound(i)
				for dur in [0.1, 0.05, 0.05]:
					particle_spawner.color = COLOR_S_COLORS[i]
					particle_spawner.arity = rng.randi_range(3, 6)
					await get_tree().create_timer(dur).timeout
					particle_spawner.spawn_particle()
				break
	
	await get_tree().create_timer(1.0).timeout

	provide_goals()	
	
	if should_provide_color_hint:
		await get_tree().create_timer(2).timeout
		provide_color_hint()
		
	if !is_level_done && has_solved_a && has_solved_s:
		is_level_done = true
		var walls: TileMapLayer = get_tree().current_scene.get_node("VisibleWorld/Walls")
		for i in range(2):
			for j in range(2):
				walls.set_cell(Vector2i(17 + i, 4 + j), 1, Vector2(i, j))
		$AudioGate.play()
	
	for i in range(is_closed_a.size()):
		close_door_a(i, false)
	for i in range(is_closed_s.size()):
		close_door_s(i, false)

func _on_pad_r_body_entered(body: Node2D) -> void:
	_on_door_entered_a(body, ColorA.RED)

func _on_pad_g_body_entered(body: Node2D) -> void:
	_on_door_entered_a(body, ColorA.GREEN)

func _on_pad_b_body_entered(body: Node2D) -> void:
	_on_door_entered_a(body, ColorA.BLUE)

func _on_pad_c_body_entered(body: Node2D) -> void:
	_on_door_entered_s(body, ColorS.CYAN)

func _on_pad_m_body_entered(body: Node2D) -> void:
	_on_door_entered_s(body, ColorS.MAGENTA)

func _on_pad_y_body_entered(body: Node2D) -> void:
	_on_door_entered_s(body, ColorS.YELLOW)

func _on_exit_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		get_node("Transition").visible = true
		await Global.transition.transit(Color(0, 0, 0, 0), Color(0, 0, 0, 1))
		get_tree().change_scene_to_file("res://scenes/levels/level3.tscn")
