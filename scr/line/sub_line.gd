class_name SubLine
extends Control


signal close_sub_line

@onready var Ui: CanvasLayer = $Ui
@onready var TextEditor: TextEdit = $Ui/Control/TextEdit
@onready var TagLabel: Label = $HBoxContainer/Tag
@onready var TextLabel: Label = $HBoxContainer/Text

var tag: String
var text: String
var can_input: bool = false


func setup(_tag: String, _text: String) -> void:
	self.tag = _tag + ": "
	self.text = _text


func set_active(activity: bool) -> void:
	can_input = activity

	if activity:
		_activate_text_editor() 


func _activate_text_editor() -> void:
	Ui.visible = true
	TextEditor.grab_focus()
	TextEditor.add_caret(len(text) - 1, 0)


func _ready() -> void:
	TagLabel.text = tag
	TextLabel.text = text
	TextEditor.text = text


func _input(event: InputEvent) -> void:
	if can_input: 
		if event.is_action_pressed("esc"):
			_close()


func _close() -> void:
	await get_tree().physics_frame
	Ui.visible = false
	TextEditor.release_focus()
	close_sub_line.emit()
	TextLabel.text = TextEditor.text
