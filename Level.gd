extends Node2D
class_name Level

var playerScore = 0;
var opponentScore = 0;
@export var powerUp:PackedScene

func _ready():
	_restart_game()

func _process(delta):
	$ScorePlayer.text = str(playerScore)
	$ScoreOpponent.text = str(opponentScore)

func _restart_game():
	$Ball.is_moving = false;
	$Ball.direction = Vector2.ZERO
	$Ball.position = Vector2(960, 540)
	#$Ball.reset_ball()
	$RestartTimer.start()
	$PowerUpTimer.start()

func _on_arco_player_body_entered(body):
	if body is Ball  :
		opponentScore += 1
		_restart_game()

func _on_arco_oponente_body_entered(body):
	if body is Ball  :
		playerScore += 1
		_restart_game()

func _on_power_up_timer_timeout():
	var instance = powerUp.instantiate()
	add_child(instance)
	#Actualmente en la escena PowerUp ya se encuentra en esa posicion
	#La posicion original era 0,0 por defecto, pero chocaba con mi ArcoPlayer y eso reiniciaba el juego
	instance.global_position = Vector2(960, 540)
