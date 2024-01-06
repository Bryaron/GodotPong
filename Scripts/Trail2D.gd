@tool
extends Line2D
class_name Trail2D

var array:Array
@export var max_lenght:int

func _process(delta):
	var pos = get_parent().get_position()
	array.push_front(pos)
	
	if array.size() > max_lenght:
		array.pop_back()
		
	clear_points()
	
	for point in array:
		add_point(point)
