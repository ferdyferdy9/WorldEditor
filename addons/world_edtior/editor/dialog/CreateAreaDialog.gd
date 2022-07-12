tool
extends "base/CreateDialog.gd"

export(NodePath) var save_dialog_path

onready var le_area_name = $MarginContainer/VBoxContainer/MarginContainer/GridContainer/le_area_name
onready var cpb_area_color = $MarginContainer/VBoxContainer/MarginContainer/GridContainer/cpb_area_color
onready var le_file_path = $MarginContainer/VBoxContainer/MarginContainer/GridContainer/HBoxContainer/le_file_path
onready var save_area_dialog:FileDialog = get_node_or_null(save_dialog_path)


func _ready() -> void:
	if save_area_dialog:
		save_area_dialog.connect("file_selected", self, "_on_file_dialog_file_selected")


func _on_file_dialog_file_selected(path:String):
	le_file_path.text = path


func _on_btn_open_file_pressed() -> void:
	save_area_dialog.popup_centered()


func _on_create() -> void:
	if le_file_path.text.empty():
		return
	
	var new_area := AreaMapData.new()
	new_area.area_name = le_area_name.text
	new_area.editor_color = cpb_area_color.color
	new_area.resource_path = le_file_path.text
	
	emit_signal("resource_created", new_area)
	visible = false
