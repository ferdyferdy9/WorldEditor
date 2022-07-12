tool
extends MenuButton


func _ready() -> void:
	get_popup().connect("id_pressed", self, "_on_popup_id_pressed")


func _on_popup_id_pressed(id:int):
	pass
