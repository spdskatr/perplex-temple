extends CanvasLayer

const tot = 0.66
var t = tot
var start_color = Color(0, 0, 0, 0)
var break_color = Color(0, 0, 0, 1)
const final_color = Color(0, 0, 0, 0)

func linp(x, x1, x2, y1, y2):
	return ((x - x1) * y2 + (x2 - x) * y1) / (x2 - x1)

func _ready() -> void:
	Global.transition = self

func _process(delta: float) -> void:
	var a
	t += delta
	if 0 <= t and t <= tot:
		if t <= 0.4 * tot:
			a = linp(t / tot, 0, 0.4, 1, 0)
			update(a * start_color + (1 - a) * break_color)
		elif t <= 0.6 * tot:
			update(break_color)
		else:
			a = linp(t / tot, 0.6, 1, 0, 1)
			update((1 - a) * break_color + a * final_color)
	else:
		update(final_color)

func update(c: Color):
	$ColorRect.color = c

func transit(b: Color, c: Color):
	t = 0
	start_color = b
	break_color = c
	await get_tree().create_timer(tot / 2).timeout
