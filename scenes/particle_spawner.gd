extends Node2D

@export var particle_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_particle_timer_timeout() -> void:
	var particle = particle_scene.instantiate()
	particle.initialize(Color.YELLOW, 1, 10, 50)
	add_child(particle)
