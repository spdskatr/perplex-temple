extends CharacterBody2D

@export var element: Element.TYPE
@export var speed: float = 500.0

func get_input():
	var direction = Input.get_vector("left", "right", "up", "down")
	var magnitude = direction.length()
	if direction.length() > 0:
		direction = direction.normalized()
		if not Input.is_action_pressed("shift") and magnitude == 1:
			rotation = direction.angle()
	
	if Element.can_move(element):
		velocity = direction * speed
	else:
		velocity = Vector2(0, 0)

func _physics_process(delta):
	get_input()
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
