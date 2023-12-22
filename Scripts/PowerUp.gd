extends CharacterBody2D
class_name PowerUp

var speed:int = 0
var direction:Vector2 = Vector2.ZERO;
var is_moving:bool = false;
var rotSpeed = 0.2

enum PowerUpEnum {POWERUP_1, POWERUP_2, POWERUP_3}
@export var powerupState: PowerUpEnum

#Necesito un audio que reproduzca de manera global para este PowerUp 
#ya que se va a destruir al tocar al jugador ó oponente
@onready var audio:AudioStreamPlayer = get_parent().find_child("AudioStreamPlayer")
@onready var timer:Timer = get_parent().find_child("RestartTimer")

func _ready():
	select_powerup()
	reset_ball()
	
func _physics_process(delta):
	if is_moving:
		rotate(rotSpeed)
		var collide = move_and_collide(direction * speed * delta)
		if collide:
			direction = direction.bounce(collide.get_normal())
			rotSpeed = rotSpeed * -1
			var collider = collide.get_collider()
			if collider is Player or collider is Opponent:
				audio.stream = $AudioPowerUp.get_stream()
				audio.play()
				#print(collider) #Obtengo el objecto mediante el collider
			else:
				$AudioCollision.play()

func reset_ball():
	timer.stop() 
	speed = 400;
	direction.x = [-1, 1][randi() % 2]
	direction.y = [-0.8, 0.8][randi() % 2]
	is_moving = true

func select_powerup(): #Cambio el estado del powerup mediante un numero aleatorio
	var random = RandomNumberGenerator.new()
	random.randomize()
	var random_number:int = random.randi_range(0, PowerUpEnum.size()-1)
	powerupState = PowerUpEnum.values()[random_number] #Cambio el estado del powerup 

func give_powerup(body):
	match powerupState:
		PowerUpEnum.POWERUP_1:
			body.powerUp1 = true
			print(str(body) + " : El estado del power-up es: " + str(powerupState) + " Agrandando la barra " + str(body.powerUp1) )
		PowerUpEnum.POWERUP_2:
			body.powerUp2 = true
			print(str(body) + " : El estado del power-up es: " + str(powerupState) + " Achicando la barra " + str(body.powerUp2))
		PowerUpEnum.POWERUP_3:
			body.powerUp3 = true
			print(str(body) + " : El estado del power-up es: " + str(powerupState) + " Cambiando escenario " + str(body.powerUp3))

func _on_area_2d_body_entered(body):
	if body is Player or body is Opponent:
		give_powerup(body)
		#print(body) #Tambien obtengo el objecto mediante el body

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
