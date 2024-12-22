class_name Line
extends Control


@onready var SubLineManagerInstance: SubLineManger = $SubLineManger

var line_data: Dictionary 


func setup(_line_data: Dictionary) -> void:
	self.line_data = _line_data


func set_active(activity: bool) -> void:
	SubLineManagerInstance.set_active(activity)


func set_sub_lines_visible(visibility: bool) -> void:
	SubLineManagerInstance.visible = visibility 


func _ready() -> void:
	SubLineManagerInstance.setup(line_data)

