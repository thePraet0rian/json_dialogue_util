class_name Line
extends Control


signal close_line

const SUBLINE_SCENE: PackedScene = preload("res://scn/line/sub_line.tscn")

@onready var Ui: CanvasLayer = $Ui
@onready var SubLineContainer: VBoxContainer = $Ui/SubLineContainer

var SubLines: Array[SubLine]

var line_data: Dictionary 

var can_input: bool = false
var sub_line_index: int = 0


func setup(_line_data: Dictionary) -> void:
	self.line_data = _line_data


func _ready() -> void:
	_setup_sub_lines()


func _setup_sub_lines() -> void:
	for key in line_data:
		var SubLineInstance: SubLine = SUBLINE_SCENE.instantiate()
		SubLineInstance.setup(key, line_data[key])
		SubLineInstance.close_sub_line.connect(_close_sub_line)
		SubLines.append(SubLineInstance)
		SubLineContainer.add_child(SubLineInstance)


func set_active(activity: bool) -> void:
	can_input = activity


func set_sub_lines_visible(visibility: bool) -> void:
	Ui.visible = visibility


func _input(event: InputEvent) -> void:
	if can_input:
		_sub_line_input(event)


func _sub_line_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		if sub_line_index > 0:
			sub_line_index -= 1
	elif event.is_action_pressed("ui_down"):
		if sub_line_index < SubLines.size() - 1:
			sub_line_index += 1 
	elif event.is_action_pressed("ui_accept"):
		await get_tree().physics_frame
		can_input = false
		SubLines[sub_line_index].set_active(true)
		return
	elif event.is_action_pressed("shift"):
		_close()
		return

	_display()


func _display() -> void:
	for i in SubLines.size():
		if i == sub_line_index:
			SubLines[i].modulate = Color8(0, 0, 0, 255)
			SubLines[i].visible = true
		else:
			SubLines[i].modulate = Color8(255, 255, 255, 255)


func _close_sub_line() -> void:
	can_input = true


func _close() -> void:
	await get_tree().physics_frame
	can_input = false
	close_line.emit()


