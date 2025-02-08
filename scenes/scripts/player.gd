extends CharacterBody2D

@export var elements: Array[Element.TYPE] = []
@export var speed: float = 500.0
@export var walk_speed : float = 200.0
@export var light: PointLight2D

func _ready() -> void:
	var slider = get_tree().current_scene.get_node_or_null("HUD/SliderBox/HSlider")
	print("test", slider)
	if slider:
		slider.value_changed.connect(_on_slider_changed)

func _on_slider_changed(value: float) -> void:
	var slider = get_tree().current_scene.get_node("HUD/SliderBox/HSlider")
	var ratio = (slider.value - slider.min_value) / (slider.max_value - slider.min_value)
	var cx = 51
	var cy = 19
	var rad = 15
	var alpha = ratio * TAU/2
	var dx = rad * cos(alpha)
	var dy = rad * sin(alpha)
	
	$EarLight.energy = (1 - ratio) * 0.25
	
	var occluder_poly = $EyeArea/Occlude.occluder.polygon.duplicate()
	var collision_poly = $EyeArea/Collision.polygon.duplicate()
	
	occluder_poly[0] = Vector2(cx + dx, cy - dy)
	occluder_poly[2] = Vector2(cx + dx, cy + dy)
	collision_poly[0] = Vector2(cx + dx, cy - dy)
	collision_poly[2] = Vector2(cx + dx, cy + dy)
	if (ratio > 0.6):
		occluder_poly[3] = occluder_poly[4]
		occluder_poly[5] = occluder_poly[4]
		collision_poly[3] = collision_poly[4]
		collision_poly[5] = collision_poly[4]
	else:
		occluder_poly[3] = Vector2(cx - rad, cy + rad)
		occluder_poly[5] = Vector2(cx - rad, cy - rad)
		collision_poly[3] = Vector2(cx - rad, cy + rad)
		collision_poly[5] = Vector2(cx - rad, cy - rad)
		
	$EyeArea/Occlude.occluder.polygon = occluder_poly
	$EyeArea/Collision.polygon = collision_poly

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
