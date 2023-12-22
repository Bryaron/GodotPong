extends CharacterBody2D
class_name Opponent

var speed = 600
@onready var ball = get_parent().find_child("Ball")

const maxSpeed = 400

var acceleration = 1500
const friction = 800

var isMoving:bool

var powerUp1:bool = false
var powerUp2:bool = false
var powerUp3:bool = false

var direction = Vector2.ZERO

func _physics_process(delta):
	direction = Vector2(0,_get_direction())

	if (direction.y == 0): 
		isMoving = false
		applyFriction(delta)
		#print("No se mueve")
		
	else: 
		isMoving = true
		accelerate(delta)
		#print("Se mueve")
		
	move_and_collide(velocity * delta)

func _get_direction():
	
	if abs(ball.position.y - position.y - 40) > 25:
		if ball.position.y > position.y:
			return 1
		else:
			return -1
	else:
		return 0

func accelerate(delta):
	velocity += (direction * acceleration * delta)
	velocity = velocity.limit_length(maxSpeed)
	
func applyFriction(delta):
	# Frenar demora mas si el input en Y no llega a zero
	# (por ejemplo si estas subiendo e inmediatamente bajas sin soltar)
	if velocity.length() > friction * delta:
		velocity -= velocity.normalized() * friction * delta
	else:
		#Hace que frene mas rapido si el input en Y es zero
		#velocity = Vector2.ZERO
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
