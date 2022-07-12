tool
extends Control


func _get_minimum_size():
	var minimum_size:Vector2
	
	for c in get_children():
		var c_end_pos = c.rect_position + c.get_minimum_size() + Vector2(100, 100)
		minimum_size.x = max(minimum_size.x, c_end_pos.x)
		minimum_size.y = max(minimum_size.y, c_end_pos.y)
	
	return minimum_size
