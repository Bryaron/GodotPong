extends Line2D

func _draw():
	draw_dashed_line(Vector2.ZERO, Vector2(0, 1080),Color.WHITE, 16, 24, true)
