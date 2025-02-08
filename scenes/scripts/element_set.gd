class_name Element_set

static func can_move(elements) -> bool:
	for el in elements:
		if !Element.can_move(el):
			return false
	return true

static func glows(elements) -> bool:
	for el in elements:
		if Element.glows(el):
			return true
	return false

static func slides(elements) -> bool:
	for el in elements:
		if Element.slides(el):
			return true
	return false
