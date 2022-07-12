class_name WorldEditorPropertyHelper
extends Object

static func create_storage(name:String, type:int, hint:int = PROPERTY_HINT_NONE, hint_string:String = "") -> Dictionary:
	var property = {
		"name" : name,
		"type" : type,
		"usage" : PROPERTY_USAGE_NOEDITOR | PROPERTY_USAGE_SCRIPT_VARIABLE,
	}
	
	if hint != PROPERTY_HINT_NONE:
		property["hint"] = hint
		property["hint_string"] = hint_string
	
	return property


static func create_property(name:String, type:int, hint:int = PROPERTY_HINT_NONE, hint_string:String = "") -> Dictionary:
	var property = {
		"name" : name,
		"type" : type,
		"usage" : PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE,
	}
	
	if hint != PROPERTY_HINT_NONE:
		property["hint"] = hint
		property["hint_string"] = hint_string
	
	return property
