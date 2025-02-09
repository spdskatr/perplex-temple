extends AudioStreamPlayer

var min_volume = -40

func _ready():
	stream = load("res://assets/sounds/soundtrack.ogg")
	process_mode = PROCESS_MODE_ALWAYS

func _process(_delta):	
	if Global.hud:
		# Forgive me for this
		var master = AudioServer.get_bus_index("Master")
		var volume = AudioServer.get_bus_volume_db(master)
		
		var slider = Global.hud.get_node("SliderBox/Panel/HSlider")
		var target = min_volume * (slider.value) / 100
		var dir = sign(target - volume)  
		
		AudioServer.set_bus_volume_db(master, volume + 0.5 * dir)
	
	if !playing:
		play()
		playing = true
	
	
