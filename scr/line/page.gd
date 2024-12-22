class_name Page
extends Control


const LINE_SCENE: PackedScene = preload("res://scn/line/line.tscn")

@onready var LineContainer: VBoxContainer = $LineContainer

var Lines: Array[Line]
var page_name: String
var page_data: Array
var can_input: bool = false
var line_index: int = 0


func setup(_page_name: String, _page_data: Array) -> void:
	self.page_name = _page_name
	self.page_data = _page_data


func open() -> void:
	can_input = true


func _ready() -> void:
	for i in page_data.size(): 
		_make_new_line(page_data[i])


func _make_new_line(_line_data: Dictionary) -> void:
	var LineInstance: Line = LINE_SCENE.instantiate()
	LineInstance.setup(_line_data)
	Lines.append(LineInstance)
	LineContainer.add_child(LineInstance)


func _input(event: InputEvent) -> void:
	if can_input:
		_line_input(event)


func _line_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		if line_index > 0:
			line_index -= 1
	elif event.is_action_pressed("ui_down"):
		if line_index < Lines.size() - 1:
			line_index += 1
	elif event.is_action_pressed("ui_accept"):
		can_input = false
		Lines[line_index].set_active(true)


	_display()


func _display() -> void:
	for i in Lines.size():
		if i == line_index:
			Lines[i].modulate = Color8(0, 0, 0, 255)
			Lines[i].set_sub_lines_visible(true)
		else:
			Lines[i].modulate = Color8(255, 255, 255, 255)
			Lines[i].set_sub_lines_visible(false)


