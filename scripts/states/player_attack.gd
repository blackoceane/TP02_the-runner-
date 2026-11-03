# État ATTACK (il lance un objet en continuant de courir)
class_name PlayerAttack
extends BaseState

@export var player : Player # (le joueur, assigné dans l'inspecteur)

func enter() -> void:
	# (tout ce qui se fait UNE seule fois au début de l'attaque : plus besoin du drapeau attaque_commencee)
	player.munitions -= 1
	print("munitions : ", player.munitions)
	player.animated_sprite_2d.play("attack") # (lancée UNE fois sinon elle recommencerait à chaque image)

func physics_update(_delta: float) -> void:
	player.velocity.x = player.SPEED # (il continue de courir pendant l'attaque)

	# Transition : l'animation attack (Loop OFF) est terminée
	if not player.animated_sprite_2d.is_playing():
		Transitioned.emit(self, "Run")
