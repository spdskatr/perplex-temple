extends CharacterBody2D

@export var element: Element.TYPE
@export var speed: float = 1000.0

func get_input():
	var direction = Input.get_vector("left", "right", "up", "down")
	var magnitude = direction.length()
	if direction.length() > 0:
		direction = direction.normalized()
		if not Input.is_action_pressed("shift") and magnitude == 1:
			rotation = direction.angle()
	velocity = direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
