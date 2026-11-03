# État FALL (il descend)
class_name PlayerFall
extends BaseState

@export var player : Player # (le joueur, assigné dans l'inspecteur)

func enter() -> void:
	player.animated_sprite_2d.play("fall") # (grâce à la gravité ça descend tout seul, pas besoin d'autre chose)

func physics_update(_delta: float) -> void:
	player.velocity.x = player.SPEED # (il continue d'avancer pendant la chute)

	# Transition : il touche le sol
	if player.is_on_floor():
		Transitioned.emit(self, "Run")
