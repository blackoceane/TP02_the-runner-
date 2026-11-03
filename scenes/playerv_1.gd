# Joueur (la classe « contexte » du patron de conception État)
# Il ne contient plus la logique des états : chaque état est un nœud enfant de StateMachine
# (Run, Jump, Fall, Attack), avec son propre script dans scripts/states/.
class_name Player # (permet aux états d'écrire « @export var player : Player »)
extends CharacterBody2D # (c'est un héritage et non une bibliothèque)

const SPEED = 100.0 # (vitesse de course)
const JUMP_VELOCITY = -400.0 # (négatif = vers le haut ; environ 82 px de haut)
var munitions = 3 # (nombre d'objets à lancer ; utilisé par les états Run et Attack)

# (on reste appuyé sur Ctrl, on prend le nœud AnimatedSprite2D, puis on le relâche : ça donne la ligne ci-dessous)
# (elle lie le nœud AnimatedSprite2D au script : c'est la « télécommande » des animations, utilisée par les états)
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# (ici seulement ce qui est COMMUN à tous les états)
	# (la StateMachine s'exécute AVANT ce code grâce à sa priorité -1 : l'état actif a déjà choisi la vitesse)
	gravite(delta)
	move_and_slide() # (déplace vraiment le joueur avec velocity)

func gravite(delta: float) -> void:
	# (si on est en l'air, on ajoute un peu de vitesse vers le bas à chaque image)
	if not is_on_floor():
		velocity += get_gravity() * delta
