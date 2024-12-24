extends CanvasLayer


signal close_editor


@onready var Editor: TextEdit = $Control/TextEdit






func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		_close()


func _close() -> void:
	close_editor.emit()
	queue_free()


