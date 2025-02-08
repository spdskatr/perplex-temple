extends CharacterBody2D

@export var elements: Array[Element.TYPE] = []
@export var speed: float = 500.0
@export var walk_speed : float = 200.0
@export var light: PointLight2D

func _ready() -> void:
	var slider = get_node_or_null("../HUD/SliderBox/HSlider")
	if slider:
		slider.value_changed.connect(_on_slider_changed)

func _on_slider_changed(value: float) -> void:
	var slider = get_node("../HUD/SliderBox/HSlider")
	var ratio = (slider.value - slider.min_value) / (slider.max_value - slider.min_value)
	var cx = 51
	var cy = 19
	var rad = 15
	var alpha = ratio * TAU/4
	var dx = rad * cos(alpha)
	var dy = rad * sin(alpha)
	$EarLight.energy = (1 - ratio) * 1
	$EyeArea/Occlude.occluder.polygon[0] = Vector2(cx + dx, cy - dy)
	$EyeArea/Occlude.occluder.polygon[2] = Vector2(cx + dx, cy + dy)
	$EyeArea/Collision.polygon[0] = Vector2(cx + dx, cy - dy)
	$EyeArea/Collision.polygon[2] = Vector2(cx + dx, cy + dy)

func get_input():
	var direction = Input.get_vector("left", "right", "up", "down")
	var magnitude = direction.length()
	if direction.length() > 0:
		direction = direction.normalized()
		if not Input.is_action_pressed("shift") and magnitude == 1:
			rotation = direction.angle()
	
	if Element_set.can_move(elements):
		if Input.is_action_pressed("shift"):
			velocity = direction * walk_speed
		else:
			velocity = direction * speed
	else:
		velocity = Vector2(0, 0)

func _physics_process(_delta):
	get_input()
	move_and_slide()

func update_light():
	# Yeah, this is a hack
	light.energy = Element_set.glows(elements)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_light()
