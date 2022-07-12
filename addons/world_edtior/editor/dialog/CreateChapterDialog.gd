tool
extends "base/CreateDialog.gd"

export(NodePath) var save_dialog_path

onready var le_chapter_name = $MarginContainer/VBoxContainer/MarginContainer/GridContainer/le_chapter_name
onready var le_file_path = $MarginContainer/VBoxContainer/MarginContainer/GridContainer/HBoxContainer/le_file_path
onready var save_chapter_dialog:FileDialog = get_node_or_null(save_dialog_path)


func _ready() -> void:
	if save_chapter_dialog:
		save_chapter_dialog.connect("file_selected", self, "_on_file_dialog_file_selected")


func _on_file_dialog_file_selected(path:String):
	le_file_path.text = path


func _on_btn_open_file_pressed() -> void:
	save_chapter_dialog.popup_centered()


func _on_create() -> void:
	if le_file_path.text.empty():
		return
	
	var new_chapter := ChapterMapData.new()
	new_chapter.chapter_name = le_chapter_name.text
	new_chapter.resource_path = le_file_path.text
	
	emit_signal("resource_created", new_chapter)
	visible = false

