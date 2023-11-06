extends CharacterBody2D
class_name PowerUp

var speed = 0
var direction = Vector2.ZERO;
var is_moving = false;
var rotSpeed = 0.2
@onready var timer = get_parent().find_child("RestartTimer")

func _ready():
	randomize()
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
				$AudioPowerUp.play()
			else:
				$AudioCollision.play()

func reset_ball():
	timer.stop()
	speed = 400;
	direction.x = [-1, 1][randi() % 2]
	direction.y = [-0.8, 0.8][randi() % 2]
	is_moving = true

