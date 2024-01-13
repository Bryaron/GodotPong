extends Node

@onready var borders = get_tree().get_nodes_in_group("border")
@onready var background = get_node("/root/Level/Background")
@onready var playerBar = get_node("/root/Level/Player/ColorRect")
@onready var opponentBar = get_node("/root/Level/Opponent/ColorRect")
@onready var line2D = get_node("/root/Level/Line2D")

func change_scenary():
	# Generar colores aleatorios para el fondo y los bordes
	var background_color = Color(randf(), randf(), randf())
	var border_color = Color(randf(), randf(), randf())
	var player_color = Color(randf(), randf(), randf())
	var opponent_color = Color(randf(), randf(), randf())
	var line2D_color = border_color

	background.color = background_color
	playerBar.color = player_color
	opponentBar.color = opponent_color
	line2D.modulate = line2D_color

	for border in borders:
		border.color = border_color

