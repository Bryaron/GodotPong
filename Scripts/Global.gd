extends Node

@onready var border = get_node("/root/Level/ContainerBorder/ContainerBorderLine")
@onready var background = get_node("/root/Level/Background")
@onready var playerBar = get_node("/root/Level/Player/ColorRect")
@onready var opponentBar = get_node("/root/Level/Opponent/ColorRect")
@onready var dashedLine2D = get_node("/root/Level/DashedLine2D")

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
	dashedLine2D.modulate = line2D_color
	border.default_color = border_color

