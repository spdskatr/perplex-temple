extends Node2D

var orientation_init: float = 0.
var orientation_final: float = 0.
var position_final: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var timer: Timer = get_node("Timer")
	if timer.is_stopped():
		return
	var ratio = timer.time_left / timer.wait_time
	var coprogress = 1 - interpolate(1 - ratio)
	self.modulate.a = interpolate(ratio)
	self.rotation = coprogress * self.orientation_init + (1 - coprogress) * self.orientation_final
	self.position = (1 - coprogress) * self.position_final

func initialize(color: Color, arity: int, lifespan: float, size: float, _range: float) -> void:
	var polygon: Polygon2D = get_node("Polygon2D")
	var array = Array()
	for i in range(arity):
		array.push_back(Vector2(sin(i * 2 * PI / arity), -cos(i * 2 * PI / arity)))
	polygon.polygon = array
	polygon.color = color
	self.scale = Vector2(size, size)
	self.rotation = randf() * 2 * PI
	self.orientation_init = self.rotation
	self.orientation_final = randf() * 2 * PI
	var direction = randf() * 2 * PI
	self.position_final = Vector2(_range * cos(direction), _range * sin(direction))
	
	var timer: Timer = get_node("Timer")
	timer.autostart = true
	timer.wait_time = lifespan

func _on_timer_timeout() -> void:
	queue_free()
	
func interpolate(x: float) -> float:
	return x * (17. + x * -18. + x * x * 7.) / 6. 
