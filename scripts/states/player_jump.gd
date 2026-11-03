# État JUMP (il monte après avoir sauté)
class_name PlayerJump
extends BaseState

@export var player : Player # (le joueur, assigné dans l'inspecteur)

func enter() -> void:
	player.velocity.y = player.JUMP_VELOCITY # (la poussée du saut, UNE seule fois : on pousse depuis le plongeoir)
	player.animated_sprite_2d.play("jump")

func physics_update(_delta: float) -> void:
	player.velocity.x = player.SPEED # (il continue d'avancer en l'air, même après avoir touché un mur)

	# Transition : au sommet (la gravité a ramené velocity.y à 0 ou plus)
	if player.velocity.y >= 0:
		Transitioned.emit(self, "Fall")
