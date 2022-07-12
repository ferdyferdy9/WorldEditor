tool
extends "base/Factory.gd"

const graph_node_scene = preload("../dragable_node/GraphNode.tscn")

func create(room_config:RoomMapConfig, border_color:Color) -> Node:
	var graph_node := graph_node_scene.instance()
	
	graph_node.room_config = room_config
	graph_node.border_color = border_color
	
	add_node_to_output(graph_node)
	return graph_node
