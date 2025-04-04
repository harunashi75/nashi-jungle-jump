extends CharacterBody2D

# Variables de physique
var gravity = 980
var jump_force = -350
var max_jumps = 1
var jumps_left = max_jumps
var max_health = 5
var current_health = max_health
var collected_fruits = 0  # Compteur de fruits

# Références aux nœuds
@onready var sprite = $AnimatedSprite2D
@onready var jump_sound = $JumpSound
@onready var health_bar = $"/root/Main/Game/UI/HealthBar"
@onready var hit_sound = $HitSound

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

func collect_fruit(value: int):
	collected_fruits += value
	var game_manager = get_node("/root/Main")
	game_manager.fruit_count += value
	game_manager.update_fruit_counter()
	print("Fruits collectés :", collected_fruits)

func take_damage(amount):
	current_health -= amount
	print("Vies restantes :", current_health)

	sprite.play("hit")  # Joue l'animation "hit"
	
	if not hit_sound.playing:
			hit_sound.play()  # Son de dégât
	
	# Empêche les autres animations de s’exécuter pendant un court moment
	set_physics_process(false)
	await get_tree().create_timer(0.3).timeout
	set_physics_process(true)

	health_bar.value = current_health

	if current_health <= 0:
		respawn()

func respawn():
	print("Respawn du joueur...")
	current_health = max_health
	health_bar.value = max_health
	global_position = Vector2(0, 0)  # Revient au début
