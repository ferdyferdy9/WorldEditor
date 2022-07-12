tool
extends "base/CreateDialog.gd"

export(NodePath) var save_dialog_path

onready var ob_area = $MarginContainer/VBoxContainer/MarginContainer/GridContainer/ob_area
onready var le_room_name = $MarginContainer/VBoxContainer/MarginContainer/GridContainer/le_room_name
onready var sb_zone_total = $MarginContainer/VBoxContainer/MarginContainer/GridContainer/sb_zone_total
onready var le_file_path = $MarginContainer/VBoxContainer/MarginContainer/GridContainer/HBoxContainer/le_file_path
onready var save_room_dialog:FileDialog = get_node_or_null(save_dialog_path)

var chapter_map_data:ChapterMapData setget set_chapter_data_map


func _ready() -> void:
	if save_room_dialog:
		save_room_dialog.connect("file_selected", self, "_on_file_dialog_file_selected")


func set_chapter_data_map(new_map:ChapterMapData) -> void:
	chapter_map_data = new_map
	
	if new_map:
		ob_area.clear()
		for area in new_map.list_area:
			ob_area.add_item(area.area_name)


func _on_file_dialog_file_selected(path:String):
	le_file_path.text = path


func _on_btn_open_file_pressed() -> void:
	save_room_dialog.popup_centered()


func _on_create() -> void:
	if le_file_path.text.empty():
		return
	
	var new_room := RoomMapConfig.new()
	new_room.room_name = le_room_name.text
	new_room.total_load_zones = sb_zone_total.value
	new_room.resource_path = le_file_path.text
	
	var selected_area = chapter_map_data.list_area[ob_area.selected]
	selected_area.list_room_config.append(new_room)
	
	emit_signal("resource_created", new_room)
	visible = false
