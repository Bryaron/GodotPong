extends CharacterBody2D
class_name Player

const maxSpeed:int = 500
var acceleration:int = 1500
const friction:int = 800

var isMoving:bool

var powerUp1:bool = false
var powerUp2:bool = false
var powerUp3:bool = false

var direction = Vector2.ZERO
var input = Vector2.ZERO

@onready var playback  = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	#print(velocity)
	input = Input.get_axis("move_up", "move_down")
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
	
func _expand_bar():
	playback.travel("expand_bar")
	
func _reduce_bar():
	playback.travel("reduce_bar")

func _reset_player(): #Restableciendo al jugador a su estado original
	playback.travel("RESET")

func _reset_powerups():
	powerUp1 = false
	powerUp2 = false
	powerUp3 = false

func _reset_timer():
		$PowerupTimer.start()

func _on_area_2d_body_entered(body):
	if body.is_in_group("power"):
		if powerUp1:
			_expand_bar()
			print(powerUp1)
		if powerUp2:
			_reduce_bar()
			print(powerUp2)
		if powerUp3:
			Global.change_scenary()
			print(powerUp3)
		
		_reset_timer()
		print(str(powerUp1) + str(powerUp2)+ str(powerUp3))
		_reset_powerups()
		body.queue_free()

func _on_powerup_timer_timeout():
	_reset_player()
