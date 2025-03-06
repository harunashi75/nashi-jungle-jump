extends Area2D

@export var banana_value: int = 1  # Valeur de la banane (par défaut 1)

@onready var anim = $AnimatedSprite2D
@onready var banana_sound = $BananaSound

func _ready():
	body_entered.connect(_on_banana_body_entered)
	anim.play("bananas")  # Lance l'animation dès le début

func _on_banana_body_entered(body):
	if body.name == "Player" and body.has_method("add_banana"):
		print("Banane collectée !")  # Debug

		# Ajouter les points et jouer le son
		body.add_banana(banana_value)
		banana_sound.play()

		# Supprimer la banane après un court délai (pour laisser le son se jouer)
		await get_tree().create_timer(0.2).timeout
		queue_free()
