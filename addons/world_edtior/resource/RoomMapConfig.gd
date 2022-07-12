tool
class_name RoomMapConfig
extends Resource

const LoadZoneConfig = preload("LoadZoneConfig.gd")
const LOADZONE_PREFIX = "load_zone_"

var scene_path:String setget set_scene_path
var room_name:String
var editor_position:Vector2 = Vector2(100, 100)
var total_load_zones:int setget set_total_load_zones
var list_load_zone_config:Array


func connect_zone(from_zone:int, next_room:RoomMapConfig, next_zone:int):
	list_load_zone_config[from_zone].next_room_handle_path = next_room.resource_path
	list_load_zone_config[from_zone].next_zone_id = next_zone


func get_next_scene_path(zone_id:int) -> String:
	var next_handle = list_load_zone_config[zone_id].get_next_room_handle()
	
	if not next_handle:
		return ""
	
	return next_handle.scene_path


func get_next_zone_id(zone_id:int) -> int:
	return list_load_zone_config[zone_id].next_zone_id


func get_all_zone_names() -> Array:
	var zone_names:Array
	
	for load_zone_config in list_load_zone_config:
		if load_zone_config != null:
			zone_names.append(load_zone_config.load_zone_name)
	
	return zone_names


func set_total_load_zones(new_total:int) -> void:
	total_load_zones = new_total
	
	_resize_load_zone_list()
	property_list_changed_notify()


func set_scene_path(new_scene_path:String) -> void:
	if new_scene_path.empty():
		return
	
	if not ResourceLoader.exists(new_scene_path):
		var msg := "The given path scene (%s) is invalid"
		printerr(msg % new_scene_path)
		return
	
	scene_path = new_scene_path


func _resize_load_zone_list():
	list_load_zone_config.resize(total_load_zones)
	for i in range(list_load_zone_config.size()):
		if list_load_zone_config[i] == null:
			list_load_zone_config[i] = LoadZoneConfig.new()


func _get(property: String):
	var result:Dictionary = _get_referred_property(property)
	if result.empty():
		return null
	
	return list_load_zone_config[result.index].get(result.property)


func _set(property: String, value) -> bool:
	var result:Dictionary = _get_referred_property(property)
	if result.empty():
		return false
	
	list_load_zone_config[result.index].set(result.property, value)
	property_list_changed_notify()
	return true


func _get_referred_property(property:String) -> Dictionary:
	if not property.begins_with(LOADZONE_PREFIX):
		return {}
	
	var result:Dictionary
	
	property = property.trim_prefix(LOADZONE_PREFIX)
	var split_result = property.split("/")
	result.index = int(split_result[0])
	result.property = split_result[1]
	
	return result


func _get_property_list() -> Array:
	var ph = WorldEditorPropertyHelper
	
	var property_list := [
		ph.create_property("scene_path", TYPE_STRING, PROPERTY_HINT_FILE, "*.tscn"),
		ph.create_property("room_name", TYPE_STRING),
		ph.create_property("editor_position", TYPE_VECTOR2),
		ph.create_property("total_load_zones", TYPE_INT),
		ph.create_storage("list_load_zone_config", TYPE_ARRAY)
	]
	
	for i in range(list_load_zone_config.size()):
		var lz_property_list:Array = list_load_zone_config[i]._get_property_list()
		
		for property in lz_property_list:
			property.name = "%s%s/%s" % [LOADZONE_PREFIX, i, property.name]
			property.usage = PROPERTY_USAGE_EDITOR
		
		property_list += lz_property_list
	
	return property_list
