extends CharacterBody2D

@export var speed: int = 60  # Vitesse de déplacement
@export var patrol_distance: int = 50  # Distance de patrouille
@export var damage: int = 1  # Dégâts infligés au joueur

var direction = 1  # 1 = droite, -1 = gauche
var start_position

@onready var sprite = $AnimatedSprite2D
@onready var player = get_node("/root/Main/Game/Player")
@onready var detection_area = $Area2D  # Détection du joueur

func _ready():
	start_position = global_position
	sprite.play("run")
	detection_area.body_entered.connect(_on_body_entered)

func _physics_process(_delta):
	velocity.x = direction * speed
	move_and_slide()

	# Change de direction si l’ennemi dépasse sa zone de patrouille
	if abs(global_position.x - start_position.x) > patrol_distance:
		direction *= -1
		sprite.flip_h = direction > 0

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(damage)
