tool
extends Control

signal request_inspect_resource(resource)

onready var map_layout_manager = $MapLayoutManager
onready var node_connector = $NodeConnector
onready var graph_container = $ScrollContainer/GraphContainer
onready var area_menu_button = $UI/Buttons/AreaMenuButton
onready var room_menu_button = $UI/Buttons/RoomMenuButton
onready var btn_reload = $UI/Buttons/btn_reload
onready var lbl_chapter_name = $UI/ChapterDesc/lbl_chapter_name
onready var lbl_total_room = $UI/ChapterDesc/lbl_total_room
onready var cb_auto_save = $UI/Buttons/cb_auto_save
onready var create_room_dialog = $Dialogs/CreateRoomDialog

var chapter_map_data:ChapterMapData setget set_chapter_map_data
var selected_room:RoomMapConfig


func _ready() -> void:
	update_ui()


func reload() -> void:
	self.chapter_map_data = chapter_map_data


func clear_chapter():
	self.chapter_map_data = null


func update_ui():
	var is_chapter_not_loaded:bool = (chapter_map_data == null)
	
	create_room_dialog.chapter_map_data = chapter_map_data
	area_menu_button.disabled = is_chapter_not_loaded
	room_menu_button.disabled = is_chapter_not_loaded
	btn_reload.disabled = is_chapter_not_loaded
	
	if not is_chapter_not_loaded:
		lbl_chapter_name.text = chapter_map_data.chapter_name
		lbl_total_room.text = "%s Rooms" % _count_chapter_room_total()
	else:
		lbl_chapter_name.text = ""
		lbl_total_room.text = ""


func save_chapter():
	if chapter_map_data == null:
		return
	
	for area in chapter_map_data.list_area:
		save_area(area)
	
	_save_resource(chapter_map_data)


func save_area(area):
	if area == null:
		return
	
	for room in area.list_room_config:
		save_room(room)
	
	_save_resource(area)


func save_room(room):
	if room == null:
		return
	
	_save_resource(room)


func set_chapter_map_data(new_map_data:ChapterMapData) -> void:
	chapter_map_data = new_map_data
	
	update_ui()
	
	if map_layout_manager:
		if new_map_data:
			map_layout_manager.update_map_view(new_map_data)
		else:
			map_layout_manager.clear_map_view()


func _save_resource(resource:Resource) -> void:
	ResourceSaver.save(
		resource.resource_path,
		resource,
		ResourceSaver.FLAG_CHANGE_PATH
	)



func _count_chapter_room_total() -> int:
	var room_total = 0
	for area in chapter_map_data.list_area:
		if area != null:
			for room in area.list_room_config:
				if room != null:
					room_total += 1
	
	return room_total


func _on_node_drag_stopped(sender) -> void:
	graph_container.minimum_size_changed()
	if cb_auto_save.pressed:
		save_room(sender.room_config)


func _on_node_focused(sender) -> void:
	selected_room = sender.room_config
	emit_signal("request_inspect_resource", sender.room_config)


func _on_area_legend_focused(sender) -> void:
	emit_signal("request_inspect_resource", sender.area_map_data)


func _on_lbl_chapter_name_focus_entered() -> void:
	emit_signal("request_inspect_resource", chapter_map_data)


func _on_CreateChapterDialog_resource_created(new_resource) -> void:
	self.chapter_map_data = new_resource


func _on_NodeConnector_connected_two_nodes() -> void:
	save_chapter()
	reload()


func _on_CreateAreaDialog_resource_created(new_resource) -> void:
	chapter_map_data.list_area.append(new_resource)
	save_area(new_resource)
	reload()


func _on_CreateRoomDialog_resource_created(new_resource) -> void:
	save_room(new_resource)
	reload()
