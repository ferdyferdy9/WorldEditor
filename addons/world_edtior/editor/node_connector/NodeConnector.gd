tool
extends Node

signal connected_two_nodes

onready var cb_auto_connect = $"../UI/Buttons/cb_auto_connect"
onready var helper_arrow = $HelperArrow
onready var room_edit_menu = $"../Popups/RoomEditMenu"

var is_auto_connect:bool
var is_connecting_node:bool

var prev_selected_node:Control
var prev_selected_room_config:RoomMapConfig
var prev_selected_zone_index:int
var selected_node:Control
var selected_room_config:RoomMapConfig
var selected_zone_index:int

func _ready() -> void:
	cb_auto_connect.connect("pressed", self, "_on_cb_auto_connect_pressed")


func _on_node_right_clicked(position, sender) -> void:
	selected_node = sender
	selected_room_config = sender.room_config
	
	room_edit_menu.clear()
	room_edit_menu.add_items(selected_room_config.get_all_zone_names())
	
	var popup_posiiton = selected_node.rect_global_position + position
	room_edit_menu.popup(Rect2(popup_posiiton, Vector2.ONE))


func _on_cb_auto_connect_pressed() -> void:
	is_auto_connect = cb_auto_connect.pressed


func _on_RoomEditMenu_index_pressed(index: int) -> void:
	selected_zone_index = index
	
	if not is_connecting_node:
		_on_start_connect()
	else:
		_on_stop_connect()
	
	is_connecting_node = !is_connecting_node
	prev_selected_node = selected_node
	prev_selected_room_config = selected_room_config
	prev_selected_zone_index = selected_zone_index


func _on_start_connect():
	helper_arrow.show_arrow(selected_node)


func _on_stop_connect():
	prev_selected_room_config.connect_zone(
		prev_selected_zone_index,
		selected_room_config,
		selected_zone_index
	)
	
	if is_auto_connect:
		selected_room_config.connect_zone(
			selected_zone_index,
			prev_selected_room_config,
			prev_selected_zone_index
		)
	
	helper_arrow.hide_arrow()
	emit_signal("connected_two_nodes")
