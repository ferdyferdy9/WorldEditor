tool
extends Control

export(NodePath) var origin_node_path:NodePath setget set_origin_node_path
export(NodePath) var target_node_path:NodePath setget set_target_node_path
export(String) var label_text:String setget set_label_text
export(Vector2) var arrow_offset:Vector2
export(Vector2) var label_offset:Vector2

onready var arrow = $Arrow
onready var label = $Arrow/Label

var origin_node:Control
var target_node:Control
var is_ready:bool


func _ready() -> void:
	is_ready = true
	
	self.label_text = label_text
	self.arrow_offset = arrow_offset
	
	if not origin_node:
		self.origin_node_path = origin_node_path
	if not target_node:
		self.target_node_path = target_node_path


func _process(delta: float) -> void:
	if null in [origin_node, target_node, arrow, label]:
		return
	
	_update_arrow()
	_update_label_position()


func _update_arrow():
	var origin_pivot = origin_node.rect_position + origin_node.rect_size * 0.5
	var target_pivot = target_node.rect_position + target_node.rect_size * 0.5
	var target_dir = target_pivot - origin_pivot
	  
	rect_position = origin_pivot
	
	arrow.rect_position = arrow_offset.rotated(atan2(target_dir.y, target_dir.x))
	arrow.arrow_direction = target_dir


func _update_label_position():
	var arrow_mid_point = Vector2.RIGHT * arrow.rect_size.x * 0.35
	var label_pivot_offset = Vector2.RIGHT * label.rect_size.x * 0.5
	label.rect_position = label_offset + arrow_mid_point - label_pivot_offset
	label.rect_rotation = -arrow.rect_rotation
	label.rect_pivot_offset = label.rect_size * 0.5


func set_origin_node_path(new_path:NodePath) -> void:
	origin_node_path = new_path
	
	if is_ready:
		origin_node = get_node_or_null(origin_node_path)


func set_target_node_path(new_path:NodePath) -> void:
	target_node_path = new_path
		
	if is_ready:
		target_node = get_node_or_null(target_node_path)


func set_label_text(new_label_text:String) -> void:
	label_text = new_label_text
	
	if label:
		label.text = new_label_text
