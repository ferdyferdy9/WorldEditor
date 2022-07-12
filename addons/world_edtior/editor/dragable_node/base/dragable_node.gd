tool
extends Control

signal node_right_Clicked(position)
signal node_moved
signal drag_started
signal drag_stopped

var is_dragging:bool = false

func _gui_input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		_on_mouse_button(event)
	elif event is InputEventMouseMotion:
		_on_mouse_motion(event)


func _on_mouse_button(event:InputEventMouseButton) -> void:
	if event.button_index == BUTTON_LEFT:
		is_dragging = event.pressed
		emit_signal("drag_started" if event.pressed else "drag_stopped")
	elif event.button_index == BUTTON_RIGHT:
		if event.pressed and not is_dragging:
			emit_signal("node_right_Clicked", event.position)


func _on_mouse_motion(event:InputEventMouseMotion) -> void:
	if is_dragging:
		rect_position += event.relative
		emit_signal("node_moved")
