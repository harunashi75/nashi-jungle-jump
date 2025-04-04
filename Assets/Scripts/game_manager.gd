extends Node

@onready var pause_menu = "/root/Main/Game/UI/PauseMenu"  # Référence au menu pause

# Basculer la pause du jeu
func toggle_pause():
	if $Game/UI/PauseMenu.visible:
		$Game/UI/PauseMenu.hide()
		get_tree().paused = false
	else:
		$Game/UI/PauseMenu.show()
		get_tree().paused = true
