extends Control

@onready var play_button = $PlayButton
@onready var exit_button = $ExitButton
@onready var volume_slider = $VolumeSlider

func _ready():
	play_button.pressed.connect(_on_play_pressed)
	exit_button.pressed.connect(_on_quit_pressed)
	
	# Charger le volume sauvegardé
	var saved_volume = load_volume()
	volume_slider.value = saved_volume
	_on_volume_changed(saved_volume)
	volume_slider.value_changed.connect(_on_volume_changed)

func _on_volume_changed(value):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
	save_volume(value)

func save_volume(value):
	var config = ConfigFile.new()
	config.set_value("audio", "volume", value)
	config.save("user://settings.cfg")

func load_volume():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		return config.get_value("audio", "volume", 1.0)
	return 1.0  # Volume par défaut

func _process(_delta):
	if Input.is_action_just_pressed("play"):
		_on_play_pressed()
	elif Input.is_action_just_pressed("quit"):
		_on_quit_pressed()

func _on_play_pressed():
	print("Play button pressed!")  # Vérifie si ça s'affiche dans la console
	var err = get_tree().change_scene_to_file("res://Assets/Scenes/main.tscn")
	if err != OK:
		print("Erreur de chargement de la scène du jeu ! Vérifie le chemin.")

func _on_quit_pressed():
	print("Quit button pressed!")  # Vérifie si ça s'affiche dans la console
	get_tree().quit()
