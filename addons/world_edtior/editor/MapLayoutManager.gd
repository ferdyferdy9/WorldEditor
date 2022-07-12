tool
extends Node

onready var area_legends = $"../UI/AreaLegends"
onready var connectors = $"../ScrollContainer/GraphContainer/Connectors"
onready var graph_nodes = $"../ScrollContainer/GraphContainer/GraphNodes"

onready var area_legend_factory = $AreaLegendFactory
onready var connector_factory = $ConnectorFactory
onready var graph_node_factory = $GraphNodeFactory

var dict_room_node:Dictionary


func update_map_view(chapter_map_data:ChapterMapData):
	clear_map_view()
	_generate_area_legends(chapter_map_data)
	_generate_graph_nodes(chapter_map_data)
	_generate_connectors(chapter_map_data)


func clear_map_view():
	for c in area_legends.get_children():
		c.queue_free()
	for c in graph_nodes.get_children():
		c.queue_free()
	for c in connectors.get_children():
		c.queue_free()


func _generate_area_legends(chapter_map_data:ChapterMapData):
	for area in chapter_map_data.list_area:
		var new_node = area_legend_factory.create(area)
		new_node.connect("focus_entered", owner, "_on_area_legend_focused", [new_node])


func _generate_graph_nodes(chapter_map_data:ChapterMapData):
	for area in chapter_map_data.list_area:
		for room_config in area.list_room_config:
			_create_graph_node(area, room_config)


func _generate_connectors(chapter_map_data:ChapterMapData):
	for area in chapter_map_data.list_area:
		for room_config in area.list_room_config:
			for load_zone_config in room_config.list_load_zone_config:
				_create_connector(room_config, load_zone_config)


func _create_graph_node(area:AreaMapData, room_config:RoomMapConfig):
	var new_node:Control = graph_node_factory.create(room_config, area.editor_color)
	
	new_node.connect("drag_stopped", owner, "_on_node_drag_stopped", [new_node])
	new_node.connect("node_right_Clicked", owner.node_connector, "_on_node_right_clicked", [new_node])
	new_node.connect("focus_entered", owner, "_on_node_focused", [new_node])
	
	dict_room_node[room_config] = new_node


func _create_connector(room_config:RoomMapConfig, load_zone_config:Resource):
	var next_room_config = load_zone_config.get_next_room_handle()
	if not dict_room_node.has(next_room_config):
		return
	
	var origin_node:Control = dict_room_node[room_config]
	var target_node:Control = dict_room_node[next_room_config]
	var label_text:String = load_zone_config.load_zone_name
	connector_factory.create(origin_node, target_node, label_text)
