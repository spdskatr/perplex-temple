extends CharacterBody2D

@export var element: Element.TYPE
@export var speed: float = 500.0
@export var light: PointLight2D

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

func _physics_process(_delta):
	get_input()
	move_and_slide()

func update_light():
	# Yeah, this is a hack
	light.energy = Element.glows(element)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_light()
