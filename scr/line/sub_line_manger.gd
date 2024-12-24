class_name SubLineManger
extends CanvasLayer


const SUBLINE_SCENE: PackedScene = preload("res://scn/line/sub_line.tscn")

@onready var SubLineContainer: VBoxContainer = $SubLineContainer

var SubLines: Array[SubLine]
var sub_line_data: Dictionary
var can_input: bool = false
var sub_line_index: int = 0


func setup(_sub_line_data: Dictionary) -> void:
	self.sub_line_data = _sub_line_data
	_setup_sub_lines()


func set_active(activity: bool) -> void:
	can_input = activity
	visible = activity


func _setup_sub_lines() -> void:
	for key in sub_line_data.keys():
		var SubLinesInstance: SubLine = SUBLINE_SCENE.instantiate()
		SubLinesInstance.setup(key, sub_line_data[key])
		SubLines.append(SubLinesInstance)
		SubLineContainer.add_child(SubLinesInstance)


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
		can_input = false
	elif event.is_action_pressed("shift"):
		pass

	_display()

	
func _display() -> void:
	for i in SubLines.size():
		if i == sub_line_index:
			SubLines[i].modulate = Color8(0, 255, 255, 255)
			SubLines[i].visible = true
		else:
			SubLines[i].modulate = Color8(255, 255, 255, 255)


