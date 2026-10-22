extends CharacterBody2D # c est un heritage et non une bibliotheque 

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var munitions = 3
# on reste appuyer sur ctrl on prend le noeud AnimatedSprite2D  puis le relache et ca donne la ligne ci dessus
# elle permet de lier le noeud AnimatedSprite2D a l action qu on va decrire sur le script  
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# si on est en l’air on ajoute un peu de vitesse vers le bas à chaque image 
	if not is_on_floor():
		velocity += get_gravity() * delta

	# au moment où on appuie sur jump et si on est au sol la vitesse verticale devient d’un coup −300 (vers le haut)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# Si une touche est pressée n importe gauche ou droite , on avance à SPEED dans cette direction
	# Sinon(else) on  ramène la vitesse vers 0 donc il freine.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if munitions > 0 && Input.is_action_just_pressed("attack"):
		munitions-=1
		
		
	
	animation()
	move_and_slide()
	# a refaire cette partie: si on est immobile et au sol alors joue l animation run
	# si non si on est au ciel et et pas sol alors joue l animation jump 
func animation():
	if 	velocity.y==0 && is_on_floor():
		animated_sprite_2d.play("run")
	elif velocity.y<0 && not is_on_floor():
		animated_sprite_2d.play("jump")
	elif velocity.y>0 && not is_on_floor():
		animated_sprite_2d.play("fall")
