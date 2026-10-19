extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
# on reste appuyer sur ctrl on prend le noeud AnimatedSprite2D  puis le relache et ca donne la ligne ci dessus 
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	animation()
	move_and_slide()
	
func animation():
	if velocity==Vector2.ZERO && is_on_floor():
		animated_sprite_2d.play("run")
	elif velocity.y!=0 && not is_on_floor():
		animated_sprite_2d.play("jump")
		 		
