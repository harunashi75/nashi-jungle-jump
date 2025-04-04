extends CharacterBody2D

# Variables de physique
var gravity = 980
var jump_force = -350
var max_jumps = 1
var jumps_left = max_jumps
var max_health = 5
var current_health = max_health

# Références aux nœuds
@onready var sprite = $AnimatedSprite2D
@onready var jump_sound = $JumpSound
@onready var health_bar = $"/root/Main/Game/UI/HealthBar"

func _physics_process(delta):
	_apply_gravity(delta)
	_handle_jump()
	_handle_movement()
	move_and_slide()

# Appliquer la gravité
func _apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

# Gérer les sauts
func _handle_jump():
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		velocity.y = jump_force
		jump_sound.play()  # Joue le son du saut
		jumps_left -= 1
		sprite.play("jump")

	if is_on_floor():
		jumps_left = max_jumps  # Réinitialiser les sauts

# Gérer le déplacement horizontal
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

func _input(event):
	if event.is_action_pressed("pause_menu"):  # Touche ESC
		var game_manager = get_node("/root/Main")  
		if game_manager:
			game_manager.toggle_pause()
		else:
			print("Erreur: Main introuvable!")

func take_damage(amount):
	current_health -= amount
	print("Touché! Vies restantes :", current_health)

	# Met à jour la barre de vie
	health_bar.value = current_health

	if current_health <= 0:
		respawn()

func respawn():
	print("Respawn du joueur...")
	current_health = max_health
	health_bar.value = max_health
	global_position = Vector2(0, 0)  # Revient au début
