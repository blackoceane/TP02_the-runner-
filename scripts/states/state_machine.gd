# StateMachine (le « gestionnaire » des états, code du cours 08)
# Les états sont ses nœuds enfants (Run, Jump, Fall, Attack).
extends Node

@export var initial_state : BaseState # (l'état de départ, choisi dans l'inspecteur : Run)
var current_state : BaseState # (l'état actif en ce moment, un seul à la fois)
var states : Dictionary = {} # (tous les états, rangés par nom : "run", "jump", ...)

func _ready() -> void:
	# On ajoute chaque enfant qui est un BaseState dans le dictionnaire
	for child in get_children():
		if child is BaseState:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition) # (on écoute le signal de chaque état)

	if initial_state:
		await owner.ready # (on attend que le joueur soit prêt : ses @onready sont remplis APRÈS les _ready des enfants)
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta) # (on délègue à l'état actif)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta) # (on délègue à l'état actif)

# Fonction pour changer d'état (appelée quand un état émet Transitioned)
func on_child_transition(state, new_state_name):
	if state != current_state:
		return # (seul l'état actif a le droit de demander un changement)

	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return # (nom d'état inconnu : on ne change rien)

	if current_state:
		current_state.exit() # (on sort de l'ancien état)

	new_state.enter() # (on entre dans le nouvel état, UNE fois)
	current_state = new_state
