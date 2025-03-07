extends Control

@onready var pause_menu = $"."  # Référence au menu pause
@onready var resume_button = $ResumeButton  # Chemin correct vers le bouton Resume
@onready var quit_button = $QuitButton  # Chemin correct vers le bouton Quit
@onready var main_menu_button = $MainMenuButton  # Chemin correct vers le bouton Main Menu

func _ready():
	print("PauseMenu visible:", pause_menu.visible)
	resume_button.pressed.connect(_on_resume_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)

	pause_menu.hide()  # Cache le menu pause au début
	set_process(true)  # Active le process pour surveiller ESC

func _process(_delta):
	var viewport_size = get_viewport_rect().size
	position = get_viewport().get_camera_2d().global_position - viewport_size / 2

func toggle_pause():
	if pause_menu.visible:
		pause_menu.hide()
		get_tree().paused = false  # Désactive la pause
	else:
		pause_menu.show()
		get_tree().paused = true  # Active la pause

func _on_resume_button_pressed():
	toggle_pause()  # Reprend le jeu

func _on_quit_button_pressed():
	get_tree().quit()  # Quitte le jeu

func _on_main_menu_button_pressed():
	get_tree().paused = false  # Désactive la pause avant de changer de scène
	get_tree().change_scene_to_file("res://Assets/Scenes/main_menu.tscn")  # Remplace par le bon chemin
