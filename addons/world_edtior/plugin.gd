tool
extends EditorPlugin

const WorldPanelScene = preload("editor/WorldMapEditor.tscn")

var world_panel

func _enter_tree():
	world_panel = WorldPanelScene.instance()
	world_panel.connect("request_inspect_resource", self, "_on_request_inspect_resource")
	get_editor_interface().get_editor_viewport().add_child(world_panel)
	make_visible(false)


func _exit_tree():
	if world_panel:
		world_panel.queue_free()


func has_main_screen():
	return true


func make_visible(visible):
	if world_panel:
		world_panel.visible = visible


func get_plugin_name():
	return "World Map"


func get_plugin_icon():
	return get_editor_interface().get_base_control().get_icon("ClassList", "EditorIcons")


func _on_request_inspect_resource(resource):
	if resource:
		get_editor_interface().inspect_object(resource)
