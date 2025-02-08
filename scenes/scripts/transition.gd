extends CanvasModulate

const tot = 0.5
var t = tot
var start_color = Color(1, 1, 1)
var final_color = Color(1, 1, 1)

func linp(x, x1, x2, y1, y2):
	return ((x - x1) * y2 + (x2 - x) * y1) / (x2 - x1)

func _process(delta: float) -> void:
	var a
	t += delta
	if 0 <= t and t <= tot:
		if t <= 0.4 * tot:
			a = linp(t / tot, 0, 0.4, 1, 0)
			set_color(a * start_color)
		elif t <= 0.6 * tot:
			set_color(0 * start_color)
		else:
			a = linp(t / tot, 0.6, 1, 0, 1)
			set_color(a * final_color)
	else:
		set_color(final_color)

func transit(c: Color):
	t = 0
	start_color = final_color
	final_color = c
	await get_tree().create_timer(tot / 2).timeout
