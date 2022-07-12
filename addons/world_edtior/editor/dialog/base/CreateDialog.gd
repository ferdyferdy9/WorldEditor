tool
extends WindowDialog

signal resource_created(new_resource)

onready var create_button:Button = $MarginContainer/VBoxContainer/btn_create as Button


func _ready() -> void:
	create_button.connect("pressed", self, "_on_create")


func _on_create() -> void:
	pass # Replace with function body.
