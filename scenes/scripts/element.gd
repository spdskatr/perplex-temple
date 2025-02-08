class_name Element

enum TYPE {DEFAULT, STONE, LIGHT, WOOD, FIRE, ICE}

static func can_move(type) -> bool:
	match type:
		TYPE.STONE:
			return false
	return true

static func glows(type) -> bool:
	match type:
		TYPE.LIGHT:
			return true
	return false
