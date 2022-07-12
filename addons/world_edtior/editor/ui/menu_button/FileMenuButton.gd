tool
extends "base/menu_button.gd"

export(NodePath) var create_chapter_dialog_path
export(NodePath) var load_chapter_dialog_path

onready var create_chapter_dialog:WindowDialog = get_node(create_chapter_dialog_path)
onready var load_chapter_dialog:FileDialog = get_node(load_chapter_dialog_path)

enum {
	NEW_CHAPTER,
	LOAD_CHAPTER,
	SAVE_CHAPTER,
	CLEAR,
}

func _on_popup_id_pressed(id:int):
	match(id):
		NEW_CHAPTER:
			create_chapter_dialog.popup_centered()
		LOAD_CHAPTER:
			load_chapter_dialog.popup_centered()
		SAVE_CHAPTER:
			owner.save_chapter()
		CLEAR:
			owner.clear_chapter()


func _on_LoadChapterDialog_file_selected(path: String) -> void:
	owner.chapter_map_data = load(path)
