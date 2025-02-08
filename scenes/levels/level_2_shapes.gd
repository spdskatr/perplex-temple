extends Node2D

var has_wall_crumbled: bool = false

@onready var hud = Global.hud

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var slider = hud.get_node("SliderBox/Panel/HSlider")
	slider.value_changed.connect(_on_slider_changed)

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
		await get_tree().create_timer(0.1).timeout
		particle_spawner.spawn_particle()
		await get_tree().create_timer(0.05).timeout
		particle_spawner.spawn_particle()
		await get_tree().create_timer(0.05).timeout
		particle_spawner.spawn_particle()
	
	
			
