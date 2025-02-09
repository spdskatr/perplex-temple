extends AudioStreamPlayer

func _ready():
	stream = load("res://assets/sounds/soundtrack.ogg")
	process_mode = PROCESS_MODE_ALWAYS

func _process(_delta):
	if !playing:
		play()
		playing = true
	
	
