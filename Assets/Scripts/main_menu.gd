extends Control

@onready var play_button = $VBoxContainer/PlayButton
@onready var exit_button = $VBoxContainer/ExitButton

func _ready():
	play_button.pressed.connect(_on_play_pressed)
	exit_button.pressed.connect(_on_quit_pressed)

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
