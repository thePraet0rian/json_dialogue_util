class_name JsonSelection
extends Node2D


signal open_file(data: Dictionary)

@onready var FileButton: Button = $Button
@onready var OpenFileDialogue: FileDialog = $Control/FileDialog


func _on_button_pressed() -> void:
	OpenFileDialogue.visible = true
	FileButton.visible = false
	FileButton.disabled = true


func _on_file_dialog_file_selected(path: String) -> void:
	var file = FileAccess.open(path, FileAccess.READ)
	var stringed_data = file.get_as_text()
	var data = JSON.parse_string(stringed_data)

	open_file.emit(data)


