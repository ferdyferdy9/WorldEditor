tool
extends "base/Factory.gd"

const area_legend_scene = preload("../area_legend/AreaLegend.tscn")

func create(area_map_data:AreaMapData) -> Node:
	var area_legend := area_legend_scene.instance()
	
	area_legend.area_map_data = area_map_data
	
	add_node_to_output(area_legend)
	return area_legend
