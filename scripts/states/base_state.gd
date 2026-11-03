# BaseState (la classe « état » du patron de conception État, code du cours 08)
# Tous les états du joueur héritent de cette classe (extends BaseState).
class_name BaseState
extends Node

# Signal pour annoncer un changement d'état (l'état dit à la StateMachine : « passe à tel état »)
signal Transitioned

func handle_inputs(_input_event: InputEvent) -> void:
	pass # (vide ici : chaque état le remplace s'il en a besoin)

func update(_delta: float) -> void:
	pass # (appelée à chaque image par _process de la StateMachine)

func physics_update(_delta: float) -> void:
	pass # (appelée à chaque image physique par _physics_process de la StateMachine)

func enter() -> void:
	pass # (appelée UNE seule fois quand on ENTRE dans l'état)

func exit() -> void:
	pass # (appelée UNE seule fois quand on QUITTE l'état)
