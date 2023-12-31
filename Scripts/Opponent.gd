extends CharacterBody2D
class_name Opponent

@onready var ball = get_parent().find_child("Ball")

const maxSpeed = 500
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
	
	if abs(ball.position.y - position.y ) > 0:
		if ball.position.y > position.y:
			return 1
		else:
			return -1
	else:
		return 0

func accelerate(delta):
	velocity += (direction * acceleration * delta)
	velocity = velocity.limit_length(maxSpeed)
	
	#Para aumenar la aceleracion cuando la bola este cerca
	if abs(ball.position.x - position.x ) < 400:
		acceleration = 3500
	
func applyFriction(delta):
	# Frenar demora mas si el input en Y no llega a zero
	# (por ejemplo si estas subiendo e inmediatamente bajas sin soltar)
	if velocity.length() > friction * delta:
		velocity -= velocity.normalized() * friction * delta
	else:
		#Hace que frene mas rapido si el input en Y es zero
		#velocity = Vector2.ZERO
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
func _expand_bar():
	var nueva_escala = Vector2(1, 2) 
	global_scale = nueva_escala
	
func _reduce_bar():
	var nueva_escala = Vector2(1, 0.5) 
	global_scale = nueva_escala

func _reset_opponent(): #Restableciendo al oponente a su estado original
	global_scale = Vector2(1, 1) 
	
func _reset_timer():
	if $PowerupTimer.is_stopped() == false:
		$PowerupTimer.stop()
	$PowerupTimer.start()


func _on_area_2d_body_entered(body):
	if body.is_in_group("power"):
		if powerUp1:
			_expand_bar()
			_reset_timer()
			powerUp1 = false
			print(powerUp1)
		if powerUp2:
			_reduce_bar()
			_reset_timer()
			powerUp2 = false
			print(powerUp2)
		else:
			pass



func _on_powerup_timer_timeout():
	_reset_opponent()
