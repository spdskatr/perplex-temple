extends Node2D

@export var color: Color = Color.WHITE
@export var arity: int = 3

const PERIOD: float = 2
const SCALE: float = 10
const RADIUS: float = 5
var time_offset: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_offset = randf()
	var polygon: Polygon2D = get_node("Polygon2D")
	var array = Array()
	for i in range(arity):
		array.push_back(Vector2(sin(i * 2 * PI / arity), -cos(i * 2 * PI / arity)))
	polygon.polygon = array
	polygon.color = color
	polygon.scale = Vector2i(SCALE, SCALE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var polygon: Polygon2D = get_node("Polygon2D")
	polygon.set_position(Vector2(0, RADIUS * sin((float(Time.get_ticks_msec()) / 1000 - time_offset) * 2 * PI / PERIOD)))
