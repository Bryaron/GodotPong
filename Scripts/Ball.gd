extends CharacterBody2D
class_name Ball

var speed = 0
var direction = Vector2.ZERO;
var is_moving = false;
var rotSpeed = 0.2
@onready var timer = get_parent().find_child("RestartTimer")

func _ready():
	randomize()

func _physics_process(delta):
	if is_moving:
		rotate(rotSpeed)
		var collide = move_and_collide(direction * speed * delta)
		if collide:
			direction = direction.bounce(collide.get_normal())
			rotSpeed = rotSpeed * -1
			$AudioCollision.play()

func reset_ball():
	timer.stop()
	speed = 400;
	direction.x = [-1, 1][randi() % 2]
	direction.y = [-0.8, 0.8][randi() % 2]
	is_moving = true

func _on_restart_timer_timeout():
	reset_ball()

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("Sali de pantalla")