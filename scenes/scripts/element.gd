class_name Element

enum TYPE {DEFAULT, STONE, LIGHT, WOOD, FIRE, ICE, WATER}

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

static func slides(type) -> bool:
	match type:
		TYPE.ICE:
			return true
	return false
	
static func wet(type) -> bool:
	match type:
		TYPE.WATER:
			return true
	return false
