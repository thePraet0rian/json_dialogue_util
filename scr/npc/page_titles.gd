class_name PageTitle
extends Label


var page_name: String


func setup(_page_name: String) -> void:
	self.page_name = _page_name


func _ready() -> void:
	self.text = page_name


