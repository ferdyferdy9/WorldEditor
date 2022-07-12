tool
extends Control

onready var color_panel = $HBoxContainer/ColorPanel
onready var label = $HBoxContainer/Label

var area_map_data:AreaMapData

func _ready() -> void:
	label.text = area_map_data.area_name
	color_panel.modulate = area_map_data.editor_color
