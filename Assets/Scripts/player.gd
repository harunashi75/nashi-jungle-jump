extends CharacterBody2D

# Variables de physique
var gravity = 980
var jump_force = -350
var max_jumps = 2
var jumps_left = max_jumps

# Gestion des bananes
var banana_count: int = 0
var total_bananas: int = 45  # Nombre total de bananes à collecter

# Références aux nœuds
@onready var sprite = $AnimatedSprite2D
@onready var banana_label = $"/root/Main/UI/BananaCount"
@onready var jump_sound = $JumpSound
@onready var pause_menu = $"/root/Main/Game/PauseMenu"

func _ready():
	# Connexion des bananes au signal de collecte
	for banana in get_tree().get_nodes_in_group("bananas"):
		banana.collected.connect(_on_banana_collected)

	# Mise à jour initiale du compteur des bananes
	update_banana_label()

func _physics_process(delta):
	_apply_gravity(delta)
	_handle_jump()
	_handle_movement()
	move_and_slide()

# 📌 Appliquer la gravité
func _apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

# 📌 Gérer les sauts
func _handle_jump():
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		velocity.y = jump_force
		jump_sound.play()  # Joue le son du saut
		jumps_left -= 1
		sprite.play("jump")

	if is_on_floor():
		jumps_left = max_jumps  # Réinitialiser les sauts

# 📌 Gérer le déplacement horizontal
func _handle_movement():
	var direction = Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * 200  # Permet de bouger même en l'air
		sprite.flip_h = (direction < 0)
	
	else:
		velocity.x = move_toward(velocity.x, 0, 20)

	# Gérer les animations correctement
	if not is_on_floor():  
		if velocity.y < 0:
			sprite.play("jump")  # Animation de saut
		else:
			sprite.play("fall")  # Animation de chute
	else:
		if direction:
			sprite.play("run")
		else:
			sprite.play("idle")

# 📌 Ajoute une étoile et met à jour l'affichage
func add_banana(value: int):
	banana_count += value
	update_banana_label()

	if banana_count >= total_bananas:
		win_game()

# 📌 Met à jour l'affichage du compteur des bananes
func update_banana_label():
	banana_label.text = str(banana_count) + " / " + str(total_bananas)

# 📌 Gestion de la collecte des bananes
func _on_banana_collected():
	print("Banane collectée !")  # Debug
	add_banana(1)

# 📌 Condition de victoire
func win_game():
	print("Félicitations ! Tu as gagné ! ")

func _input(event):
	if event.is_action_pressed("pause_menu"):  # Touche ESC
		pause_menu.toggle_pause()
