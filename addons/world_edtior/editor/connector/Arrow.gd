tool
extends Control

const COLOR_GLASS_WHITE = Color(1.0, 1.0, 1.0, 0.5)

export(float) var arrow_width:float = 5 setget set_arrow_width
export(Vector2) var arrow_direction:Vector2 setget set_arrow_direction


func _draw() -> void:
	_draw_arrow_head()
	_draw_arrow_line()


func _adjust_rect_size_to_arrow_direction():
	rect_size = Vector2(arrow_direction.length(), arrow_width)


func _adjust_rotation_to_arrow_direction():
	rect_rotation = rad2deg(atan2(arrow_direction.y, arrow_direction.x))


func _draw_arrow_line():
	var line_dir:Vector2 = Vector2.RIGHT * arrow_direction.length()
	draw_line(Vector2.ZERO, line_dir, COLOR_GLASS_WHITE, arrow_width * 0.5, true)


func _draw_arrow_head():
	var arrow_head_offset:Vector2 = Vector2.RIGHT * arrow_direction.length() * 0.5
	
	var p0:Vector2 = arrow_head_offset + Vector2.UP * arrow_width * 2
	var p1:Vector2 = arrow_head_offset + Vector2.DOWN * arrow_width * 2
	var p2:Vector2 = arrow_head_offset + Vector2.RIGHT * arrow_width * 2
	
	_draw_polygon([p0, p1, p2], COLOR_GLASS_WHITE)


func _draw_polygon(points:Array, color:Color):
	draw_polygon(
		PoolVector2Array(points), 
		PoolColorArray([color]),
		PoolVector2Array(), 
		null, null, true
	)


func _update_draw():
	_adjust_rect_size_to_arrow_direction()
	_adjust_rotation_to_arrow_direction()
	call_deferred("update")


func set_arrow_width(new_arrow_width:float) -> void:
	arrow_width = new_arrow_width
	_update_draw()


func set_arrow_direction(new_arrow_direction:Vector2) -> void:
	arrow_direction = new_arrow_direction
	_update_draw()
