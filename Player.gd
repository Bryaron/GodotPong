extends CharacterBody2D
class_name Player

const maxSpeed = 400
#const speed = 1000
var acceleration = 1500
const friction = 800
var isMoving

var direction = Vector2.ZERO
var input = Vector2.ZERO


func _physics_process(delta):
	#print(velocity)
	input = Input.get_axis("ui_up", "ui_down")
	direction = Vector2(0, input)
	
	if (direction.y == 0): 
		isMoving = false
		applyFriction(delta)
		#print("No se mueve")
		
	else: 
		isMoving = true
		accelerate(delta)
		#print("Se mueve")
		
	move_and_collide(velocity * delta)
	
	
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
	

