extends Node2D

@export var color: Color
@export var arity: int
@export var particle_scene: PackedScene
@export var wait_time: float = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer: Timer = get_node("ParticleTimer")
	if wait_time > 0:
		timer.wait_time = wait_time
		timer.autostart = true
		timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_particle_timer_timeout() -> void:
	if wait_time > 0:
		spawn_particle()

func spawn_particle() -> void:
	var timer: Timer = get_node("ParticleTimer")
	var particle = particle_scene.instantiate()
	particle.initialize(color, arity, 1, 5, 50)
	add_child(particle)
