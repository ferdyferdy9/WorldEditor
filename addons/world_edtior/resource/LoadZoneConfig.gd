tool
extends Resource

var load_zone_name:String
var next_room_handle_path:String
var next_zone_id:int


func get_next_room_handle() -> Resource:
	if next_room_handle_path.empty():
		return null
	
	if not ResourceLoader.exists(next_room_handle_path):
		var msg = "[%s, %s] Couldn't load handle at path %s."
		printerr(msg % [self, load_zone_name, next_room_handle_path])
		return null
	
	return ResourceLoader.load(next_room_handle_path)


func _get_property_list() -> Array:
	var ph := WorldEditorPropertyHelper
	var property_list := [
		ph.create_property("load_zone_name", TYPE_STRING),
		ph.create_property("next_room_handle_path", TYPE_STRING, PROPERTY_HINT_FILE, "*.tres"),
	]
	
	var handle := get_next_room_handle()
	if handle:
		var zone_names:Array = handle.get_all_zone_names()
		var zone_list_str:String = _list_to_str(zone_names)
		
		property_list.append(
			ph.create_property("next_zone_id", TYPE_INT, PROPERTY_HINT_ENUM, zone_list_str)
		)
	
	return property_list


static func _list_to_str(list:Array) -> String:
	var result:String
	
	for s in list:
		result += "," + s
	result.erase(0, 1)
	
	return result
