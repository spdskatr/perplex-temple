class_name Element
extends Node

enum TYPE {WOOD, METAL}

func floats(type) -> bool:
	match type:
		TYPE.WOOD:
			return true
		TYPE.METAL:
			return false
	return false
