class_name SubLine
extends Control


@onready var TagLabel: Label = $Tag
@onready var TextLabel: Label = $Text

var tag: String
var text: String


func setup(_tag: String, _text: String) -> void:
	self.tag = _tag
	self.text = _text


func _ready() -> void:
	TagLabel.text = tag
	TextLabel.text = text
