extends Node2D

@export var color: Color
@export var arity: int
@export var particle_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_particle_timer_timeout() -> void:
	var timer: Timer = get_node("ParticleTimer")
	var particle = particle_scene.instantiate()
	particle.initialize(color, arity, timer.wait_time, 5, 50)
	add_child(particle)
