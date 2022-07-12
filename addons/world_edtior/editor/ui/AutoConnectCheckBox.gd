extends CheckBox

signal check_toggled(isChecked)

func _on_AutoConnectCheckBox_pressed() -> void:
	emit_signal("check_toggled", self.pressed)
