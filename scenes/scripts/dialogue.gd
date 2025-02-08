extends Panel

@export var text_speed: float = 0.05  # Speed of text appearing
var dialogue_queue = []
var is_typing = false
var skip_current_text = false

@onready var label = $Label  # Adjust this path if needed


func show_text(new_text: String):
	var first_dialogue = dialogue_queue.size() == 0
	dialogue_queue.append(new_text)
	
	# Start text box
	if first_dialogue and not is_typing:
		show()
		get_tree().paused = true
		_process_text()

func _process_text():
	if dialogue_queue.is_empty():
		return
	
	var text_to_display = dialogue_queue.pop_front()
	is_typing = true
	label.text = ""
	
	for c in text_to_display:
		label.text += c
		if not skip_current_text:
			await get_tree().create_timer(text_speed).timeout

	is_typing = false
	skip_current_text = false

func _unhandled_input(event):
	if event.is_action_pressed("accept"):
		if is_typing:
			skip_current_text = true
		else:
			if dialogue_queue.is_empty():
				hide()  # Hide the text box when dialogue is finished
				get_tree().paused = false
			else:
				_process_text()
