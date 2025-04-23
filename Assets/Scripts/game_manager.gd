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

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_KP_1:  # NumPad 1
				teleport_player(Vector2(-418, 1328))
			KEY_KP_2:  # NumPad 2
				teleport_player(Vector2(616, 1056))
			KEY_KP_3:  # NumPad 3
				teleport_player(Vector2(1017, 720))
			KEY_KP_4:  # NumPad 4
				teleport_player(Vector2(-8.0, 1168))
			KEY_KP_5:  # NumPad 5
				teleport_player(Vector2(-1031, 1200))
			# Tu peux ajouter autant de niveaux que tu veux ici

func teleport_player(position: Vector2):
	var player = get_node_or_null("/root/Main/Game/Player")
	if player:
		player.global_position = position
	else:
		print("Joueur introuvable pour téléportation.")
