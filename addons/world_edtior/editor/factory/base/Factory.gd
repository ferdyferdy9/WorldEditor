tool
extends Node

export(NodePath) var output_node_path:NodePath setget set_output_node_path

var output_node:Node
var is_ready:bool


func _ready() -> void:
	is_ready = true
	
	self.output_node_path = output_node_path


func add_node_to_output(node:Node):
	if output_node:
		output_node.add_child(node)


func set_output_node_path(new_node_path:NodePath):
	output_node_path = new_node_path
	if is_ready:
		output_node = get_node_or_null(new_node_path)
