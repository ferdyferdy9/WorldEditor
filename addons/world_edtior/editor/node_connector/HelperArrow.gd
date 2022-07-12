tool
extends Node

onready var arrow = $Arrow

var origin_node:Control

func _ready() -> void:
	arrow.visible = false


func _process(delta: float) -> void:
	if arrow and arrow.visible and origin_node:
		arrow.rect_global_position = origin_node.rect_global_position + origin_node.rect_size * 0.5
		arrow.arrow_direction = arrow.get_global_mouse_position() - arrow.rect_global_position


func show_arrow(_origin_node:Control):
	origin_node = _origin_node
	arrow.show()


func hide_arrow():
	origin_node = null
	arrow.hide()


func _on_RoomEditMenu_about_to_show() -> void:
	set_process(false)


func _on_RoomEditMenu_popup_hide() -> void:
	set_process(true)
