extends Area2D

@export var fruit_value: int = 1  # Nombre de points du fruit

@onready var sprite = $AnimatedSprite2D
@onready var collect_sound = $CollectSound

func _ready():
	sprite.play("fruitwave")  # Joue l'animation du fruit
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("player"):  # Vérifie que c'est bien le joueur
		body.collect_fruit(fruit_value)  # Ajoute les points au joueur
		sprite.play("collected")
		if collect_sound:
			collect_sound.play()
			await collect_sound.finished
		queue_free()  # Supprime le fruit
