# État RUN (il court tout seul, modèle Temple Run)
class_name PlayerRun
extends BaseState

@export var player : Player # (le joueur, assigné dans l'inspecteur)

func enter() -> void:
	player.animated_sprite_2d.play("run") # (animation jouée en entrant dans l'état)

func physics_update(_delta: float) -> void:
	player.velocity.x = player.SPEED # (mouvement : il court tout seul vers la droite)

	# Transitions (vérifiées en dernier)
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		Transitioned.emit(self, "Jump") # (sauter seulement depuis le sol)
	elif Input.is_action_just_pressed("attack") and player.munitions > 0:
		Transitioned.emit(self, "Attack") # (attaquer seulement s'il reste des munitions, sinon il continue de courir)
	elif not player.is_on_floor():
		Transitioned.emit(self, "Fall") # (il tombe du bord d'une plateforme sans avoir sauté)
