extends CanvasModulate

const tot = 0.5
var t = tot

func linp(x, x1, x2, y1, y2):
	return ((x - x1) * y2 + (x2 - x) * y1) / (x2 - x1)

func _process(delta: float) -> void:
	var a
	t += delta
	if 0 <= t and t <= tot:
		if t <= 0.4 * tot:
			a = linp(t / tot, 0, 0.4, 1, 0)
		elif t <= 0.6 * tot:
			a = 0
		else:
			a = linp(t / tot, 0.6, 1, 0, 1)
		update(a)
	else:
		update(1)

func update(a: float) -> void:
	set_color(Color(a, a, a))

func transit():
	t = 0
	await get_tree().create_timer(tot / 2).timeout
