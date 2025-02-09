class_name Player
extends CharacterBody2D

@export var speed: float = 500.0
@export var walk_speed : float = 200.0
@export var light: PointLight2D
@export var frozen: bool = false
@export var visible_objects: Dictionary = {}
@export var dying: bool = false
var frozen_objects = null
var checkpoint_pos: Vector2 = Vector2(0, 0)
var since_standing = 0.0
@export var ratio = 1.

func get_elements():
	if ratio < 1e-7:
		return frozen_objects
	return visible_objects.values()

func _ready() -> void:
	checkpoint_pos = self.global_position
	Global.player = self

func on_slider_changed(slider) -> void:
	ratio = (slider.value - slider.min_value) / (slider.max_value - slider.min_value)
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

func get_input(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	var magnitude = direction.length()
	
	var elements = get_elements()
	var is_sliding = Element_set.slides(elements)
	
	if direction.length() > 0:
		since_standing += _delta
		direction = direction.normalized()
		if !Input.is_action_pressed("shift") and !is_sliding and magnitude == 1:
			rotation = direction.angle()
	else:
		since_standing = 0
	
	var standing_mod = min(1, since_standing / 0.15) 
	if is_sliding:
		var multiplier = min(3 * walk_speed, velocity.length() * (1 + 0.005))
		velocity = velocity.normalized() * multiplier
	elif Element_set.can_move(elements):
		if Input.is_action_pressed("shift"):
			velocity = direction * walk_speed * standing_mod
		else:
			velocity = direction * speed * standing_mod
	else:
		velocity = Vector2(0, 0)
	
	if Input.is_action_pressed("seppuku"):
		die()

func die() -> void:
	if not dying:
		dying = true
		await Global.transition.transit(Color(1, 0, 0, 0), Color(0, 0, 0, 1))
		position = checkpoint_pos
		await get_tree().create_timer(0.2).timeout
		dying = false

func is_wet() -> bool:
	return Element_set.wet(get_elements())

func _physics_process(_delta):
	get_input(_delta)
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if ratio > 0:
		frozen_objects = []
		for e in visible_objects.values().duplicate():
			if e == Element.TYPE.WATER:
				frozen_objects.append(e)
	# right 0 
	# down 0.25
	# left 0.5
	# up -0.25
	var r = rotation / (2*PI)
	var sprite = $Sprite2D
	sprite.rotation = -rotation
	if 0.12 < r and r < 0.37:
		sprite.frame = 0
	if -0.12 < r and r < 0.12:
		sprite.frame = 1
	if -0.37 < r and r < -0.12:
		sprite.frame = 2
	if 0.37 < r and r < 0.62:
		sprite.frame = 3
		
