tool
extends "base/menu_button.gd"

export(NodePath) var create_room_dialog_path
export(NodePath) var edit_room_area_dialog_path

onready var create_room_dialog:WindowDialog = get_node(create_room_dialog_path)
onready var edit_room_area_dialog:WindowDialog = get_node(edit_room_area_dialog_path)

enum {
	CREATE_ROOM,
	EDIT_ROOM_AREA,
	FIX_SCENE_PATH,
	FIX_ALL_SCENE_PATH,
	DELETE_ROOM,
}

func _on_popup_id_pressed(id:int):
	match(id):
		CREATE_ROOM:
			create_room_dialog.popup_centered()
		EDIT_ROOM_AREA:
			edit_room_area_dialog.popup_centered()
		FIX_SCENE_PATH:
			fix_scene_path(owner.selected_room)
			owner.reload()
		FIX_ALL_SCENE_PATH:
			fix_all_scene_path()
			owner.reload()
		DELETE_ROOM:
			pass


func fix_all_scene_path():
	for area in owner.chapter_map_data.list_area:
		for room in area.list_room_config:
			fix_scene_path(room)


func fix_scene_path(room:RoomMapConfig):
	if ResourceLoader.exists(room.scene_path):
		return
	
	var result = _find_scene_file_by_name(room.resource_path)
	if not result.empty():
		room.scene_path = result
		return
	
	result = _find_scene_file_by_dir(room.resource_path)
	if not result.empty():
		room.scene_path = result
		return
	
	print("[%s] Scene Path failed to fixed" % room)


func _find_scene_file_by_name(room_resource_path:String) -> String:
	var file_path:String = room_resource_path
	file_path = file_path.trim_suffix(file_path.get_extension())
	file_path = file_path.trim_suffix("_rmap")
	file_path += ".tscn"
	if ResourceLoader.exists(file_path):
		return file_path
	return ""


func _find_scene_file_by_dir(room_resource_path:String) -> String:
	var dir := Directory.new()
	var path = room_resource_path.get_base_dir()
	if dir.open(path) != OK:
		return ""
	
	dir.list_dir_begin()
	
	var file_name = dir.get_next()
	while not file_name.empty():
		if not dir.current_is_dir() and file_name.ends_with(".tscn"):
			return path.plus_file(file_name)
		file_name = dir.get_next()
	
	return ""
