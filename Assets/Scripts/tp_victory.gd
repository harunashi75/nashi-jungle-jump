extends Area2D

@export var teleport_position: Vector2  # Position où téléporter le joueur
@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("idle")  # Joue l'animation de base (par défaut)
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:  # Vérifie si c'est le joueur
		print("Téléportation!")
		body.global_position = teleport_position  # Déplace le joueur
