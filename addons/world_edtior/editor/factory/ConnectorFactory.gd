tool
extends "base/Factory.gd"

const connector_scene = preload("../connector/Connector.tscn")

func create(origin_node:Control, target_node:Control, label_text:String) -> Node:
	var connector := connector_scene.instance()
	
	connector.arrow_offset = Vector2(0, -15)
	connector.origin_node = origin_node
	connector.target_node = target_node
	connector.label_text = label_text
	connector.label_offset = Vector2(0, -40)
	
	add_node_to_output(connector)
	return connector
