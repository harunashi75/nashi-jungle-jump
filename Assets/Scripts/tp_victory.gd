extends Area2D

@export var teleport_position: Vector2  # Position où téléporter le joueur
@onready var victory_sound = $VictorySound  # Ton nœud audio
@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("idle")  # Joue l'animation de base (par défaut)
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		var player = body  # On utilise le corps détecté directement
		player.reset_health()
		player.global_position = teleport_position
		victory_sound.play()
