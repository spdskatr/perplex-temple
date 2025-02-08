class_name Element
extends Node

enum TYPE {DEFAULT, STONE}

func can_move(type) -> bool:
	match type:
		TYPE.DEFAULT:
			return true
		TYPE.STONE:
			return false
	return true
