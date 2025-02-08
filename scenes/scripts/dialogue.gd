extends Panel

@export var text_speed: float = 0.05  # Speed of text appearing
var dialogue_queue = []
var is_typing = false

@onready var label = $Label  # Adjust this path if needed

func show_text(new_text: String):
	if is_typing:
		return  # Prevent new text while typing
	dialogue_queue.append(new_text)
	if dialogue_queue.size() == 1:
		_process_text()

func _process_text():
	if dialogue_queue.is_empty():
		return
	
	var text_to_display = dialogue_queue.pop_front()
	is_typing = true
	label.text = ""
	
	for char in text_to_display:
		label.text += char
		await get_tree().create_timer(text_speed).timeout  # Simulates typing effect

	is_typing = false

func _unhandled_input(event):
	if event.is_action_pressed("accept") and not is_typing:
		if dialogue_queue.is_empty():
			hide()  # Hide the text box when dialogue is finished
		else:
			_process_text()
