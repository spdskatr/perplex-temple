extends AudioStreamPlayer

var min_volume = -40

func _ready():
	stream = load("res://assets/sounds/soundtrack.ogg")
	process_mode = PROCESS_MODE_ALWAYS

func _process(_delta):
	
	var slider = Global.hud.get_node("SliderBox/Panel/HSlider")
	var target = min_volume * (slider.value) / 100
	var dir = sign(target - volume_db)  
	
	volume_db += 0.3 * dir
	
	if !playing:
		play()
		playing = true
	
	
