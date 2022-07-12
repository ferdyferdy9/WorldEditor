tool
extends "base/dragable_node.gd"

export(bool) var is_selected:bool setget set_is_selected
export(Resource) var room_config setget set_room_config
export(Color) var border_color = Color(0.2, 0.2, 0.2) setget set_border_color

onready var label:Label = $MarginContainer/PanelContainer/MarginContainer/Label

func _ready() -> void:
	self.room_config = room_config
	self.is_selected = is_selected
	
	label.self_modulate = Color.white if ResourceLoader.exists(room_config.scene_path) else Color(1.0, 0.25, 0.25)


func set_room_config(new_room_config:Resource) -> void:
	room_config = new_room_config
	
	if new_room_config and label:
		rect_position = room_config.editor_position
		label.text = room_config.room_name


func set_is_selected(new_value:bool) -> void:
	is_selected = new_value
	
	if label:
		label.modulate = Color.yellow if is_selected else Color.white


func set_border_color(new_color:Color) -> void:
	border_color = new_color
	
	self_modulate = new_color


func _on_GraphNode_focus_entered() -> void:
	self.is_selected = true


func _on_GraphNode_focus_exited() -> void:
	self.is_selected = false


func _on_GraphNode_node_moved() -> void:
	if room_config:
		room_config.editor_position = rect_position
