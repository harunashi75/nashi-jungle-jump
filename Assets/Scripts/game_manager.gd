extends Node

var fruit_count = 0

@onready var fruit_label = $"/root/Main/Game/UI/FruitsLabel"
@onready var pause_menu = "/root/Main/Game/UI/PauseMenu"  # Référence au menu pause

# Met à jour l'affichage du compteur
func update_fruit_counter():
	fruit_label.text = "Fruits: " + str(fruit_count)

# Basculer la pause du jeu
func toggle_pause():
	if $Game/UI/PauseMenu.visible:
		$Game/UI/PauseMenu.hide()
		get_tree().paused = false
	else:
		$Game/UI/PauseMenu.show()
		get_tree().paused = true
