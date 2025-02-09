extends Panel

@export var text_speed: float = 0.02  # Speed of text appearing
@onready var rng = RandomNumberGenerator.new()
var dialogue_queue = []
var whos_typing = "player"
var is_typing = false
var skip_current_text = false
@onready var sprites = {
	"player": preload("res://assets/faces/placeholder.png"), 
	"npc": preload("res://assets/faces/placeholder2.png")
}

@onready var label = $Label
@onready var portrait = $Portrait

var time_since_skip: float = 0
var skip_cooldown: float = 0.3
var time_since_boop: float = 0
var boop_cooldown: float = 0.05

func queue_text(sprite: String, new_text: String):
	dialogue_queue.append([sprite, new_text])

func done():
	while not dialogue_queue.is_empty():
		await get_tree().create_timer(0.1).timeout

func start_text(pause_game = true):
	if not visible:
		# Start text box
		show()
		get_tree().paused = pause_game
		await _process_text()

func _process_text():
	if dialogue_queue.is_empty():
		return
	
	var textbox = dialogue_queue.pop_front()
	var sprite = sprites[textbox[0]]
	var text_to_display = textbox[1]
	whos_typing = textbox[0]
	is_typing = true
	portrait.texture = sprite
	label.text = ""
	
	for c in text_to_display:
		label.text += c
		if not skip_current_text:
			await get_tree().create_timer(text_speed).timeout

	is_typing = false
	skip_current_text = false

func _process(delta):
	time_since_skip += delta
	time_since_boop += delta
	
	if is_typing and time_since_boop > boop_cooldown:
		var audio = $AudioStreamPlayer
		if whos_typing == "player":
			audio.pitch_scale = 1.2
		else:
			audio.pitch_scale = 1.6
		audio.pitch_scale *= rng.randf_range(0.9, 1.1)
			
		time_since_boop = 0
		audio.play()
	
	if Input.is_action_pressed("accept") and time_since_skip > skip_cooldown:
		time_since_skip = 0
		
		if is_typing:
			skip_current_text = true
		else:
			if dialogue_queue.is_empty():
				hide()  # Hide the text box when dialogue is finished
				get_tree().paused = false
			else:
				_process_text()
	
