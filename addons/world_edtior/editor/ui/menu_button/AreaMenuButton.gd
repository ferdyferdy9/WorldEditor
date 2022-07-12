tool
extends "base/menu_button.gd"

export(NodePath) var create_area_dialog_path
export(NodePath) var edit_area_dialog_path

onready var create_area_dialog:WindowDialog = get_node(create_area_dialog_path)
onready var edit_area_dialog:WindowDialog = get_node(edit_area_dialog_path)

enum {
	CREATE_AREA,
	EDIT_AREA,
	DELETE_AREA,
}

func _on_popup_id_pressed(id:int):
	match(id):
		CREATE_AREA:
			create_area_dialog.popup_centered()
		EDIT_AREA:
			edit_area_dialog.popup_centered()
		DELETE_AREA:
			pass
